# `lib.luapi.block`

Extends: **table**

## Parsed tagged block of class fields or methods

## 📜 Fields

+ **title : string = nil**
+ **description : string = nil**
+ **name : string = nil**
  `Gets from `self.extends.name``
+ **codename : string = nil**
  `Sets before parsing in `lib.luapi.file``
+ **codeargs : list=string = nil**
  `Real function arguments (from `lib.luapi.file`)`
+ **fields : list=lib.luapi.block.line = nil**
  `Line after `>``
+ **returns : list=lib.luapi.block.line = nil**
  `Line after `<``
+ **extends : lib.luapi.block.line = nil**
  `Line after `@``

## 💡 Methods

+ **init (block)**
  `Take comments block and create structured data block`

## 👨‍👦 Types

**WIP**

## 🧩 Details

### Method `init`

Take comments block and create structured data block

→ `block` : **table=lib.luapi.block** _[nil]_

## 🖇️ Links

[Go up](..)
