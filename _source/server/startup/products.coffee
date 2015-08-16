
###

  Screen Printing

###
apparelOptions = [
  {
    name: "< 24"
    label: "< 24"
    message: "Call for pricing"
  }
  {
    name: "24 - 47"
    label: "24 - 47"
    low:
      value: 24
      modifier: [
        {
          action: "add"
          value: 5.5
        }
      ]
    high:
      value: 47
      modifier: [
        {
          action: "add"
          value: 1.6
        }
      ]
  }
  {
    name: "48 - 96"
    label: "48 - 96"
    low:
      value: 48
      modifier: [
        {
          action: "add"
          value: 4.25
        }
      ]
    high:
      value: 96
      modifier: [
        {
          action: "add"
          value: 1.4
        }
      ]
  }
  {
    name: "97 - 250"
    label: "97 - 250"
    low:
      value: 97
      modifier: [
        {
          action: "add"
          value: 3
        }
      ]
    high:
      value: 250
      modifier: [
        {
          action: "add"
          value: 1.2
        }
      ]
  }
  {
    name: "251 - 499"
    label: "251 - 499"
    low:
      value: 251
      modifier: [
        {
          action: "add"
          value: 2
        }
      ]
    high:
      value: 499
      modifier: [
        {
          action: "add"
          value: 1
        }
      ]
  }
  {
    name: "500 - 1000"
    label: "500 - 1000"
    low:
      value: 500
      modifier: [
        {
          action: "add"
          value: 1.5
        }
      ]
    high:
      value: 1000
      modifier: [
        {
          action: "add"
          value: 1
        }
      ]
  }
  {
    name: "over 1000"
    label: "over 1000"
    message: "Call for pricing"
  }
]

Apollos.products.upsert {name: "ss tee"},
  $set:
    name: "ss tee"
    label: "Short Sleeve Tee"
    service: "screen-printing"
    basePrice: 3
    modifiers: [
      {
        name: "quality"
        label: "Choose Quality"
        type: "select"
        required: true
        options: [
          {
            name: "good"
            label: "Good"
            basePrice: 0
          }
          {
            name: "better"
            label: "Better"
            basePrice: 1.5
          }
          {
            name: "best"
            label: "Best"
            basePrice: 3
          }
          {
            name: "premium"
            label: "Premium"
            basePrice: 4.5
          }
        ]
      }
      {
        name: "quantity"
        label: "Choose Quantity"
        type: "select"
        range: true
        required: true
        options: apparelOptions
      }
    ]

Apollos.products.upsert {name: "ls tee"},
  $set:
    name: "ls tee"
    label: "Long Sleeve Tee"
    service: "screen-printing"
    basePrice: 5
    modifiers: [
      {
        name: "quality"
        label: "Choose Quality"
        type: "select"
        required: true
        options: [
          {
            name: "good"
            label: "Good"
            basePrice: 0
          }
          {
            name: "better"
            label: "Better"
            basePrice: 1.5
          }
          {
            name: "best"
            label: "Best"
            basePrice: 3
          }
          {
            name: "premium"
            label: "Premium"
            basePrice: 4.5
          }
        ]
      }
      {
        name: "quantity"
        label: "Choose Quantity"
        type: "select"
        range: true
        required: true
        options: apparelOptions
      }
    ]

Apollos.products.upsert {name: "pullover"},
  $set:
    name: "pullover"
    label: "Pullover Hood"
    service: "screen-printing"
    basePrice: 12
    modifiers: [
      {
        name: "quality"
        label: "Choose Quality"
        type: "select"
        required: true
        options: [
          {
            name: "good"
            label: "Good"
            basePrice: 0
          }
          {
            name: "better"
            label: "Better"
            basePrice: 5
          }
          {
            name: "best"
            label: "Best"
            basePrice: 10
          }
        ]
      }
      {
        name: "quantity"
        label: "Choose Quantity"
        type: "select"
        range: true
        required: true
        options: apparelOptions
      }
    ]

Apollos.products.upsert {name: "headwear"},
  $set:
    name: "headwear"
    label: "Headwear"
    service: "screen-printing"
    basePrice: 6
    modifiers: [
      {
        name: "quality"
        label: "Choose Quality"
        type: "select"
        required: true
        options: [
          {
            name: "good"
            label: "Good"
            basePrice: 0
          }
          {
            name: "better"
            label: "Better"
            basePrice: 2.5
          }
          {
            name: "best"
            label: "Best"
            basePrice: 5
          }
        ]
      }
      {
        name: "quantity"
        label: "Choose Quantity"
        type: "select"
        range: true
        required: true
        options: apparelOptions
      }
    ]

Apollos.products.upsert {name: "other"},
  $set:
    name: "other"
    label: "Other"
    service: "screen-printing"
    message: "Call for pricing"



###

  Custom Printing

###
Apollos.products.upsert {name: "archival artists canvas"},
  $set:
    name: "archival artists canvas"
    label: "Archival Artists Canvas"
    service: "custom-printing"
    basePrice: 10
    modifiers: [
      {
        name: "size"
        label: "Choose Size"
        type: "input"
        input:
          label: "Square feet"
          name: "square feet"
        required: true
        modifier: [
          action: "multiply"
          value: 4
        ]
      }
    ]

Apollos.products.upsert {name: "archival fine art paper"},
  $set:
    name: "archival fine art paper"
    label: "Archival Fine Art Paper"
    service: "custom-printing"
    basePrice: 12
    modifiers: [
      {
        name: "size"
        label: "Choose Size"
        type: "input"
        input:
          label: "Square feet"
          name: "square feet"
        required: true
        modifier: [
          action: "multiply"
          value: 4
        ]
      }
    ]

Apollos.products.upsert {name: "vinyl banner"},
  $set:
    name: "vinyl banner"
    label: "Vinyl Banner"
    service: "custom-printing"
    basePrice: 7
    modifiers: [
      {
        name: "size"
        label: "Choose Size"
        type: "input"
        input:
          label: "Square feet"
          name: "square feet"
        required: true
        modifier: [
          action: "multiply"
          value: 4
        ]
      }
    ]

Apollos.products.upsert {name: "basic paper"},
  $set:
    name: "basic paper"
    label: "Basic Paper"
    service: "custom-printing"
    basePrice: 5
    modifiers: [
      {
        name: "size"
        label: "Choose Size"
        type: "input"
        input:
          label: "Square feet"
          name: "square feet"
        required: true
        modifier: [
          action: "multiply"
          value: 4
        ]
      }
    ]

Apollos.products.upsert {name: "mounted signage"},
  $set:
    name: "mounted signage"
    label: "Mounted Signage"
    service: "custom-printing"
    basePrice: 12
    modifiers: [
      {
        name: "size"
        label: "Choose Size"
        type: "input"
        input:
          label: "Square feet"
          name: "square feet"
        required: true
        modifier: [
          action: "multiply"
          value: 4
        ]
      }
    ]


###

  Letterpress

###
letterpressOptions = [
  {
    name: "single weight cotton"
    label: "Single Weight Cotton"
    basePrice: 0.15
  }
  {
    name: "double weight cotton"
    label: "Double Weight Cotton"
    basePrice: 0.65
  }
  {
    name: "single weight colored"
    label: "Single Weight Colored"
    basePrice: 0.35
  }
  {
    name: "double weight colored"
    label: "Double Weight Colored"
    basePrice: 1
  }
  {
    name: "duplex/specialty"
    label: "Duplex/Specialty"
    basePrice: 1.4
  }
]

letterpressQuantities = [
  {
    name: "under 100"
    label: "Under 100"
    message: "Call for pricing"
  }
  {
    name: "150"
    label: "150"
    value: 150
    modifier: [
      {
        action: "multiply"
        value: 150
      }
    ]
  }
  {
    name: "200"
    label: "200"
    value: 200
    modifier: [
      {
        action: "multiply"
        value: 200
      }
    ]
  }
  {
    name: "250"
    label: "250"
    value: 250
    low:
      value: 0
      modifier: [
        {
          action: "multiply"
          value: 250
        }
      ]
  }
  {
    name: "300"
    label: "300"
    value: 300
    modifier: [
      {
        action: "multiply"
        value: 300
      }
    ]
  }
  {
    name: "400"
    label: "400"
    value: 400
    modifier: [
      {
        action: "multiply"
        value: 400
      }
    ]
  }
  {
    name: "500+"
    label: "500+"
    message: "Call for pricing"
  }
]

letterpressColors = [
  {
    name: "one color"
    label: "One color"
    modifier: [
      {
        action: "multiply"
        value: 1.1
      }
      {
        action: "add"
        value: 30
      }
    ]
  }
  {
    name: "two colors"
    label: "Two colors"
    modifier: [
      {
        action: "multiply"
        value: 1.2
      }
      {
        action: "add"
        value: 70
      }
    ]
  }
  {
    name: "three colors"
    label: "Three colors"
    modifier: [
      {
        action: "multiply"
        value: 1.3
      }
      {
        action: "add"
        value: 105
      }
    ]
  }
  {
    name: "four colors"
    label: "Four colors"
    modifier: [
      {
        action: "multiply"
        value: 1.4
      }
      {
        action: "add"
        value: 140
      }
    ]
  }
]

Apollos.products.upsert {name: "business card"},
  $set:
    name: "business card"
    label: "Business Card"
    service: "letterpress"
    basePrice: 0.01
    modifiers: [
      {
        name: "type"
        label: "Choose Paper Type"
        type: "select"
        required: true
        options: letterpressOptions
      }
      {
        name: "quantity"
        label: "Choose Quantity"
        type: "select"
        required: true
        options: letterpressQuantities
      }
      {
        name: "color"
        label: "Choose Print Colors"
        type: "select"
        required: true
        options: letterpressColors
      }
    ]
    modifier: [
      {
        action: "divide"
        modifier: "quantity"
      }
      {
        action: "multiply"
        value: 3
      }
    ]


Apollos.products.upsert {name: "small card"},
  $set:
    name: "small card"
    label: "Small Card"
    service: "letterpress"
    basePrice: 0.01
    modifiers: [
      {
        name: "type"
        label: "Choose Paper Type"
        type: "select"
        required: true
        options: letterpressOptions
      }
      {
        name: "quantity"
        label: "Choose Quantity"
        type: "select"
        required: true
        options: letterpressQuantities
      }
      {
        name: "color"
        label: "Choose Print Colors"
        type: "select"
        required: true
        options: letterpressColors
      }
    ]
    modifier: [
      {
        action: "divide"
        modifier: "quantity"
      }
      {
        action: "multiply"
        value: 3
      }
    ]

Apollos.products.upsert {name: "letterhead"},
  $set:
    name: "letterhead"
    label: "Letterhead"
    service: "letterpress"
    basePrice: 0.25
    modifiers: [
      {
        name: "type"
        label: "Choose Paper Type"
        type: "select"
        required: true
        options: letterpressOptions
      }
      {
        name: "quantity"
        label: "Choose Quantity"
        type: "select"
        required: true
        options: letterpressQuantities
      }
      {
        name: "color"
        label: "Choose Print Colors"
        type: "select"
        required: true
        options: letterpressColors
      }
    ]
    modifier: [
      {
        action: "divide"
        modifier: "quantity"
      }
      {
        action: "multiply"
        value: 3
      }
    ]

Apollos.products.upsert {name: "invitation set"},
  $set:
    name: "invitation set"
    label: "Invitation Set"
    service: "letterpress"
    message: "Call for more information"
