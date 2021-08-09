# `lib.luapi.file`

Extends: **list=lib.luapi.file.class**

## Single lua file

IDEA: Parse and write list of requires

## 📜 Fields

+ **reqpath : string**
+ **fullpath : string**
+ **content : lib.luapi.file.content = nil**
  `gets removed after File:write()`

## 💡 Methods

+ **init (reqpath, fullpath)**
+ **read : success**
+ **parse : success**
+ **write : success**

## 👨‍👦 Types

+ **lib.luapi.file.class**

## 🧩 Details

### Method `init`

→ `reqpath` : **string**

→ `fullpath` : **string**

### Method `read`

← `success` : **lib.luapi.file|nil**

### Method `parse`

> + IDEA: Escape whatever you want with `\` (partitially works)
> + IDEA: Support OOP: inheritance

← `success` : **lib.luapi.file|nil**

### Method `write`

← `success` : **lib.luapi.file|nil**

## 🖇️ Links

[Go up](..)
