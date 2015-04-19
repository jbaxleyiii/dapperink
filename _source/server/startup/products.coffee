
if Den.products.find().count() is 0

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

  Den.products.insert
    name: "ss tee"
    label: "Short Sleeve Tee"
    service: "screen printing"
    basePrice: 3
    modifiers: [
      {
        name: "quality"
        lablel: "Choose Quality"
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
        name: "volume"
        label: "Choose Quantity"
        type: "select"
        range: true
        required: true
        options: apparelOptions
      }
    ]


  Den.products.insert
    name: "ls tee"
    label: "Long Sleeve Tee"
    service: "screen printing"
    basePrice: 5
    modifiers: [
      {
        name: "quality"
        lablel: "Choose Quality"
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
        name: "volume"
        label: "Choose Quantity"
        type: "select"
        range: true
        required: true
        options: apparelOptions
      }
    ]

  Den.products.insert
    name: "pullover"
    label: "Pullover Hood"
    service: "screen printing"
    basePrice: 12
    modifiers: [
      {
        name: "quality"
        lablel: "Choose Quality"
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
        name: "volume"
        label: "Choose Quantity"
        type: "select"
        range: true
        required: true
        options: apparelOptions
      }
    ]

  Den.products.insert
    name: "headwear"
    label: "Headwear"
    service: "screen printing"
    basePrice: 6
    modifiers: [
      {
        name: "quality"
        lablel: "Choose Quality"
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
        name: "volume"
        label: "Choose Quantity"
        type: "select"
        range: true
        required: true
        options: apparelOptions
      }
    ]

  Den.products.insert
    name: "headwear"
    label: "Headwear"
    service: "screen printing"
    message: "Please call for options"
