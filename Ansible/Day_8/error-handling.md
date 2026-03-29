## 1. What is error handling in Ansible?

Error handling in Ansible means controlling what happens when a task fails.

By default, if a task fails on a host, Ansible stops execution for that host and moves on based on playbook behavior.

Error handling helps you:

- continue when a non-critical task fails
- stop early when something is wrong
- recover with alternate actions
- make playbooks safer and easier to debug

---

## 2. What is a failure in Ansible?

A task is usually marked as failed when:

- a command returns a non-zero exit code
- a module cannot complete its action
- a file or package is missing
- connection/authentication fails
- the task condition is not met in a way that causes failure

Example:

```yaml
- name: Run a command that fails
  ansible.builtin.command: /bin/false
```

This fails because `/bin/false` returns a non-zero exit code.

---

## 3. Default behavior on failure

By default:

- if a task fails on a host, Ansible stops running remaining tasks for that host
- other hosts may continue depending on the run

Example:

```yaml
---
- hosts: all
  tasks:
    - name: Install nonexistent package
      ansible.builtin.apt:
        name: fake-package
        state: present

    - name: This task will not run on failed host
      ansible.builtin.debug:
        msg: "Hello"
```

If package install fails, the debug task will not run on that host.

---

## 4. Common error handling techniques

Main techniques include:

- `ignore_errors`
- `failed_when`
- `changed_when`
- `register`
- `block`, `rescue`, `always`
- `any_errors_fatal`
- `max_fail_percentage`
- `until`, `retries`, `delay`

---

## 5. `ignore_errors`

Use `ignore_errors: true` when you want Ansible to continue even if a task fails.

Example:

```yaml
- name: Try to install a package
  ansible.builtin.apt:
    name: fake-package
    state: present
  ignore_errors: true

- name: Continue even if previous task fails
  ansible.builtin.debug:
    msg: "Playbook continues"
```

### Meaning

Even if package installation fails, Ansible continues to the next task.

### Use case

Useful for:

- non-critical tasks
- cleanup tasks
- optional steps

### Caution

Do not overuse it, because real failures may be hidden.

---

## 6. `ignore_unreachable`

Sometimes a host is unreachable, not just failed.

Example:

```yaml
- name: Ping hosts
  ansible.builtin.ping:
  ignore_unreachable: true
```

### Meaning

If host cannot be reached, Ansible continues instead of stopping completely for that condition.

---

## 7. `failed_when`

Use `failed_when` to define your own failure condition.

Example:

```yaml
- name: Run custom command
  ansible.builtin.command: echo "success"
  register: cmd_output
  failed_when: "'error' in cmd_output.stdout"
```

### Meaning

This task fails only if the word `error` appears in output.

Another example:

```yaml
- name: Check application status
  ansible.builtin.command: /usr/local/bin/check_app
  register: app_result
  failed_when: app_result.rc != 0
```

This is useful when default module behavior is not enough.

---

## 8. `changed_when`

Use `changed_when` to control when a task should be marked as changed.

Example:

```yaml
- name: Run status check
  ansible.builtin.command: systemctl is-active apache2
  register: service_status
  changed_when: false
```

### Meaning

This task only checks status, so it should not show as changed.

Another example:

```yaml
- name: Run custom script
  ansible.builtin.command: /tmp/myscript.sh
  register: script_output
  changed_when: "'updated' in script_output.stdout"
```

### Why important?

It keeps reports accurate and reduces misleading output.

---

## 9. `register`

`register` stores the result of a task in a variable so later tasks can inspect it.

Example:

```yaml
- name: Check if file exists
  ansible.builtin.command: ls /tmp/testfile
  register: file_check
  ignore_errors: true
```

Then you can use it:

```yaml
- name: Print result
  ansible.builtin.debug:
    var: file_check
```

Common registered values:

- `stdout`
- `stderr`
- `rc`
- `changed`

---

## 10. `block`, `rescue`, `always`

This is one of the most useful error handling features.

- `block` = main tasks
- `rescue` = run if block fails
- `always` = run no matter what

Example:

```yaml
---
- hosts: all
  become: true
  tasks:
    - name: Application deployment block
      block:
        - name: Install package
          ansible.builtin.apt:
            name: fake-package
            state: present

        - name: Start application service
          ansible.builtin.service:
            name: myapp
            state: started

      rescue:
        - name: Print failure message
          ansible.builtin.debug:
            msg: "Deployment failed. Running rescue steps."

        - name: Write error log
          ansible.builtin.copy:
            content: "Deployment failed on {{ inventory_hostname }}"
            dest: /tmp/deploy_error.log

      always:
        - name: Always print completion message
          ansible.builtin.debug:
            msg: "This runs whether success or failure happens."
```

### Meaning

- if tasks in `block` succeed, `rescue` is skipped
- if a task in `block` fails, `rescue` runs
- `always` runs in both cases

### Use case

Great for:

- deployments
- rollback logic
- cleanup
- logging

---

## 11. Practical example: package install with rescue

```yaml
---
- hosts: all
  become: true
  tasks:
    - block:
        - name: Install nginx
          ansible.builtin.apt:
            name: nginx
            state: present
            update_cache: yes

      rescue:
        - name: Notify install failure
          ansible.builtin.debug:
            msg: "Nginx installation failed on {{ inventory_hostname }}"

      always:
        - name: Final message
          ansible.builtin.debug:
            msg: "Install attempt completed"
```

---

## 12. `any_errors_fatal`

If you want the whole play to stop when any host has an error, use:

```yaml
---
- hosts: all
  any_errors_fatal: true
  tasks:
    - name: Run important step
      ansible.builtin.command: /bin/false
```

### Meaning

If one host fails, Ansible stops for all hosts.

### Use case

Good for:

- critical distributed operations
- cluster changes
- steps where all hosts must stay consistent

---

## 13. `max_fail_percentage`

This controls how many hosts can fail before the play stops.

Example:

```yaml
---
- hosts: webservers
  max_fail_percentage: 30
  tasks:
    - name: Restart web service
      ansible.builtin.service:
        name: apache2
        state: restarted
```

### Meaning

If failures exceed 30% of targeted hosts, Ansible stops the play.

### Use case

Good for rolling changes in large environments.

---

## 14. Retries with `until`

Sometimes failures are temporary.  
For those cases, use retry logic.

Example:

```yaml
- name: Wait for service to become active
  ansible.builtin.command: systemctl is-active apache2
  register: service_check
  until: service_check.stdout == "active"
  retries: 5
  delay: 10
```

### Meaning

- try task
- if not active, wait 10 seconds
- retry up to 5 times

### Use case

Useful for:

- startup checks
- waiting for services
- waiting for ports
- waiting for APIs

---

## 15. Practical example: waiting for application readiness

```yaml
- name: Check application health endpoint
  ansible.builtin.uri:
    url: http://localhost:8080/health
    method: GET
    status_code: 200
  register: health_result
  until: health_result.status == 200
  retries: 6
  delay: 5
```

This helps when the app needs time to come up.

---

## 16. Demonstrating practical scenarios

### Scenario 1: Optional package installation

```yaml
- name: Try installing optional package
  ansible.builtin.apt:
    name: htop
    state: present
  ignore_errors: true
```

If `htop` fails, playbook still continues.

### Scenario 2: Service check without marking changed

```yaml
- name: Check nginx status
  ansible.builtin.command: systemctl is-active nginx
  register: nginx_status
  changed_when: false
```

This is a check only, not a change.

### Scenario 3: Custom failure rule

```yaml
- name: Run validation script
  ansible.builtin.command: /usr/local/bin/validate_app.sh
  register: validate_result
  failed_when: "'FAILED' in validate_result.stdout"
```

Here failure depends on output text.

### Scenario 4: Deployment with rescue

```yaml
---
- hosts: appservers
  become: true
  tasks:
    - block:
        - name: Copy app file
          ansible.builtin.copy:
            src: app.jar
            dest: /opt/app/app.jar

        - name: Restart app service
          ansible.builtin.service:
            name: myapp
            state: restarted

      rescue:
        - name: Rollback placeholder message
          ansible.builtin.debug:
            msg: "Deployment failed. Start rollback process."

      always:
        - name: Notify deployment attempt finished
          ansible.builtin.debug:
            msg: "Deployment flow completed."
```

---

## 17. Best practices for error handling

1. Do not blindly use `ignore_errors`.  
   Only use it for non-critical steps.

2. Use `register` and inspect results.  
   This gives better control over decision-making.

3. Use `changed_when: false` for check-only commands.  
   This keeps output clean and correct.

4. Use `block` and `rescue` for important workflows.  
   Especially useful in deployments and configuration changes.

5. Use retries for temporary failures.  
   Do not fail immediately if the service just needs time.

6. Stop globally for critical workflows.  
   Use `any_errors_fatal: true` when partial failure is dangerous.

7. Keep failure messages clear.  
   Use debug messages or logs so troubleshooting is easy.

8. Prefer idempotent modules over raw commands.  
   Modules usually handle errors better than ad hoc shell commands.

---

## 18. Common interview-style explanation

**Error handling in Ansible is the process of controlling task failures and deciding whether to continue, retry, rescue, or stop execution.**  
It is commonly implemented using `ignore_errors`, `failed_when`, `changed_when`, `register`, `block/rescue/always`, and retry logic like `until`, `retries`, and `delay`.

---

**Ansible error handling is about deciding whether a failure should be ignored, retried, rescued, or allowed to stop the play.**
