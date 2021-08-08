# `lib.luapi.block`

Extends: **table**

## Parsed tagged comment block of any TYPE

## 📜 Fields

+ **title : string = nil**
+ **description : string = nil**
+ **name : string = nil**
+ **codename : string = nil**
  `Sets before parsing in lib.luapi.file`
+ **codeargs : list=string = nil**
  `Real function arguments (from lib.luapi.file)`
+ **fields : list=lib.luapi.block.line = nil**
  `Line after >`
+ **returns : list=lib.luapi.block.line = nil**
  `Line after <`
+ **typeset : lib.luapi.block.line = nil**
  `Line after @`

## 💡 Methods

+ **init (block)**
  `Take comments block and create structured data block`

## 👨‍👦 Types

**WIP**
+ **lib.luapi.block.line**

## 🧩 Details

### Method `init`

Take comments block and create structured data block

→ `block` : **table=lib.luapi.block** _[nil]_

## 🖇️ Links

[Go up](..)
