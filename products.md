

## Short Sleeve Tee Shirt

*Base Price: $3.00*

_Modifiers:_
  - Good: + 0.00
  - Better: + 1.50
  - Best: + 3.00
  - Premium: + 4.50

_Volume:_
  - < 24: Call for pricing
  - 24 - 47: + 5.50
    - top modifier: + 1.60
  - 48 - 96: + 4.25
    - top modifier: + 1.40
  - 97 - 250: + 3.00
    - top modifier: + 1.20
  - 256 - 499: + 2.00
    - top modifier: + 1.00
  - 500 - 1000: + 1.50
    - top modifier: + 1.0
  - > 1000: Call for pricing


## Archival Artists Canvas

Base Price: $10

option:
  name:
    type: String
    optional: false
  label:
    type: String
    optional: true
  baseVolume:
    type: Number
    optional: true
  topVolume:
    type: Number
    optional: false
  basePrice:
    type: Number
    optional: true
  topPrice:
    type: Number
    optional: true
  message:
    type: String
    optional: true


Modifer:
  name:
    type: String
    optional: false
  label:
    type: String
    optional: true
  options:
    type: [option]
    optional: true
  type:
    type: String
    optional: false
  required:
    type: Boolean
    optional: false

Products
  name:
    type: String
    optional: false
  service:
    type: String
    optional: true
  basePrice:
    type: Number
    optional: true
  modifiers:
    type [modifier]
    optional: true
  volume:
    type: String
    optional: false
