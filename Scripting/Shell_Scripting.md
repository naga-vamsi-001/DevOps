# 🐚 Shell Scripting Concepts

This repository showcases essential concepts of Shell Scripting, useful for DevOps, system administrators, and automation engineers. It includes syntax, usage, and examples to help understand shell scripting fundamentals.

---

## 📘 What is Shell Scripting?

Shell scripting is a way to automate tasks in Unix/Linux using a sequence of shell commands stored in a file. These files are executed by shell interpreters like Bash.

---

## 📚 Topics Covered

### 1. 🧾 Basics of Shell Scripting
- `.sh` file is a shell script file.
- `#!` (shebang) defines which interpreter to use (`#!/bin/bash` for Bash).
- Run with `sh script.sh` or make it executable.

### 2. 🔐 Linux SSH Access
- SSH connects to servers securely.
- Use `.pem` for Linux/Git Bash, `.ppk` for PuTTY.
- Tools: Git Bash, PuTTY, MobaXterm, WinSCP.

### 3. 🧮 Variables and Arguments
- Assign values: `Fruit=Apple` (no spaces).
- Read values: `read Name`, `DATE=$(date)`.
- Positional arguments: `$1`, `$2`, `$@` (all), `$#` (count).

### 4. 📊 Data Types
- Default: strings.
- Integers: `$((NUMBER1 + NUMBER2))`.
- Arrays: `arr=(one two three)`.

#### Example:
```bash
Fruits=(Apple Banana Mango)
echo "First: ${Fruits[0]}"
```

### 5. 🔢 Exit Codes & Booleans
- `$?` stores exit code of last command.
- `0` = success, `1-127` = error.

### 6. ❓ Conditions
- `if`, `then`, `else`, `fi` used for branching logic.
- Example:
```bash
if [ $USERID -eq 0 ]; then
  echo "Root"
else
  echo "No root"
fi
```

### 7. 🔁 Functions
Reusable blocks of logic. Accepts arguments and uses exit codes.

#### Example:
```bash
Validate() {
  if [ $1 -ne 0 ]; then
    echo "$2..Failed"
    exit 1
  else
    echo "$2...Success"
  fi
}
```

### 8. 📤 Output Redirection
- `>` : overwrite stdout
- `>>` : append
- `2>` : stderr
- `&>` : both stdout and stderr

---

## 🛠 How to Use

Clone and run scripts:
```bash
chmod +x script.sh
./script.sh
```
