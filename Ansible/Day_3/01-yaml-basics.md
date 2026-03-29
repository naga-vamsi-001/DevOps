## What is YAML?

YAML stands for **YAML Ain't Markup Language**. It is a **human-readable data serialization format** commonly used for:

- configuration files
- data exchange
- DevOps tools like Ansible and Kubernetes

---

## Why YAML is used

YAML is popular because it is:

- easy for humans to read
- simple to write
- good for structured data
- widely used in DevOps

---

## Basic YAML syntax

YAML mainly uses:

- `key: value`
- indentation with spaces
- hyphen `-` for lists

Example:

```yaml
app: nginx
port: 80
active: true
```

---

## Basic YAML data types

### 1. String

A string is text.

```yaml
message: Hello, World!
name: John Doe
city: New York
```

---

### 2. Number

A number can be an integer or decimal.

```yaml
age: 30
port: 8080
price: 99.99
```

---

### 3. Boolean

A boolean has only two values:

- `true`
- `false`

```yaml
is_active: true
is_admin: false
```

---

### 4. List / Sequence

A list stores multiple values.

```yaml
fruits:
  - Apple
  - Orange
  - Banana
```

Inline format:

```yaml
fruits: [Apple, Orange, Banana]
```

---

### 5. Dictionary / Mapping

A mapping stores key-value pairs.

```yaml
person:
  name: John Doe
  age: 30
  city: New York
```

---

### 6. List of dictionaries

A list can contain mappings.

```yaml
employees:
  - name: John
    age: 30
    city: New York
  - name: Jane
    age: 28
    city: Chicago
```

---

### 7. Nested data

YAML supports nesting of mappings and lists.

```yaml
family:
  parents:
    - name: Jane
      age: 50
    - name: John
      age: 52
  children:
    - name: Jimmy
      age: 22
    - name: Jenny
      age: 20
```

---

### 8. Null / Empty value

A null means no value.

```yaml
middle_name: null
nickname:
```

---

## Same data in Text, JSON, and YAML

### Text

```text
Server is web01
Port is 8080
Environment is dev
```

### JSON

```json
{
  "server": "web01",
  "port": 8080,
  "environment": "dev"
}
```

### YAML

```yaml
server: web01
port: 8080
environment: dev
```

---

## Difference between Text, JSON, and YAML

### Text file

A text file is plain readable text. It does **not have a fixed universal structure by default**.

It may contain:

- notes
- logs
- commands
- config values
- random lines

So plain text does not enforce structure on its own.

---

### JSON file

JSON is a **structured data format** with strict syntax rules.

It uses:

- curly braces `{}`
- square brackets `[]`
- double quotes for keys and string values
- commas between items

JSON is commonly used in:

- APIs
- data exchange
- application payloads

---

### YAML file

YAML is also a **structured data format** with defined syntax rules.

It uses:

- indentation
- `key: value`
- hyphen `-` for list items

YAML is commonly used in:

- Ansible playbooks
- Kubernetes manifests
- config files

---

## Are JSON and YAML data serialization formats?

Both **JSON** and **YAML** are **data serialization formats**.

### What is data serialization?

Data serialization means converting data into a format that can be:

- stored
- transferred
- read by another program later

Example:

A Python dictionary in memory:

```python
data = {"server": "web01", "port": 8080}
```

can be serialized into JSON or YAML.

---

## Important YAML rules

### 1. Indentation matters

Use spaces, not tabs.

Correct:

```yaml
person:
  name: John
  age: 30
```

---

### 2. Use `key: value`

```yaml
env: dev
```

---

### 3. Lists use `-`

```yaml
servers:
  - app1
  - app2
```

---

## Summary table

| Type | Meaning | Example |
|------|---------|---------|
| String | Text value | `name: John` |
| Number | Numeric value | `age: 30` |
| Boolean | True/False value | `active: true` |
| List | Multiple items | `fruits: [Apple, Orange]` |
| Mapping | Key-value pairs | `person: {name: John, age: 30}` |
| Null | Empty value | `middle_name: null` |

---

## Quick memory

- **Text** = plain content
- **JSON** = strict structured data
- **YAML** = human-friendly structured data
- **Serialization** = converting data into a storable or transferable format
