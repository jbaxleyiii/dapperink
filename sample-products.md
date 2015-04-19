

Den.service.insert({

  name: "screen printing"
  label "Screen printing"
  description: "Cras mattis consectetur purus sit amet fermentum. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Donec ullamcorper nulla non metus auctor fringilla."
  images:
    hero: "//images.dapperink.s3/hero/screen-printing.png"
  colors:
    primay: "#fff"
    secondary: "#444"
    tertiary: "#980324"
  template: "service"
  url: ["/apparel", "/"]
  quote:
    name: "apparel"
    label: "Apparel"
    action: "Choose Apparel Type"
    modifier: "volume"
  employees: [
    {
      firstName: "Matthew"
      lastName: "Moreau"
      nickname: "Matt"
      img: "//images.dapperink.s3/staff/matt"
      profile:
        "//images.dapperink.s3/staff/internal/matt"
      title: "Owner Operator"
      email: "matt@dapperink.com"
      endeavors: [
        {
          name: "The Landmark Project"
          link: "www.landmarkproject.com"
        }
      ]
      social: [
        {
          name: "facebook"
          url: "//facebook.com/matt"
        }
        {
          name: "twitter"
          url: "//twitter.com/matt"
        }
      ]
    }
  ]

})

Den.products.insert({

  name: "ss tee"
  label: "Short Sleeve Tee Shirt"
  basePrice: 3
  modifiers: [
    {
      name: "quality"
      label: "Quality"
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
          basePrice: 1.50
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
      label: "Quality"
      type: "select"
      range: true
      required: true
      options: [
        {
          name: "< 24"
          label: "0 - 24"
          message: "Call for pricing"
        }
        {
          name: "24 - 47"
          label: "24 - 47"
          low:
            value: 24
            modifier: [
              {
                action: "multiply"
                value: 5.5
              }
            ]
          high:
            value: 47
            modifier: [
              {
                action: "multiply"
                value: 7.1
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
                action: "multiply"
                value: 4.25
              }
            ]
          high:
            value: 96
            modifier: [
              {
                action: "multiply"
                value: 5.65
              }
            ]
        }
      ]
    }
  ]

})


Den.service.insert({

  name: "custom"
  label "Custom printing"
  description: "Cras mattis consectetur purus sit amet fermentum. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Donec ullamcorper nulla non metus auctor fringilla."
  images:
    hero: "//images.dapperink.s3/hero/cusom-printing.png"
  template: "service"
  colors:
    primay: "#fff"
    secondary: "#444"
    tertiary: "#980324"
  url: ["/custom"]
  quote:
    name: "banner"
    label: "Banner"
    action: "Select Material"
    modifier: "size"


})

Den.products.insert({

  name: "archival artists canvas"
  label: "Archival Artists Canvas"
  basePrice: 10
  modifiers: [
    {
      name: "size"
      label: "Total Square Footage"
      type: "input"
      required: true
      modifier: [
        {
          action: "multiply"
          value: 4
        }
      ]
    }
  ]

})


Den.service.insert({

  name: "letterpress"
  label "Letter Press"
  description: "Cras mattis consectetur purus sit amet fermentum. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Donec ullamcorper nulla non metus auctor fringilla."
  images:
    hero: "//images.dapperink.s3/hero/letter-press.png"
  colors:
    primay: "#fff"
    secondary: "#444"
    tertiary: "#980324"
  url: ["/lettepress", "/letter-press"]
  template: "service"
  quote:
    name: "letterpress"
    label: "Letter Press"
    action: "Choose Print Type"
    modifier: "volume"


})


Den.products.insert({

  name: "business card"
  label: "Buisness Card"
  basePrice: 0.01
  modifiers: [
    {
      name: "paper type"
      label: "Choose paper type"
      type: "select"
      required: true
      options: [
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
          label: "Duplex / Specialty"
          basePrice: 1.4
        }
      ]
    }
    {
      name: "volume"
      label: "Choose Quantity"
      type: "select"
      required: true
      options: [
        {
          name: "under 100"
          label: "Under 100"
          message: "Call for pricing"
        }
        {
          name: "150"
          label: "150"
          value: 150
          basePrice: 0
        }
        {
          name: "200"
          label: "200"
          basePrice: 0
          value: 200
        }
      ]
    }
    {
      name: "colors"
      label: "Choose Colors"
      type: "select"
      required: true
      options: [
        {
          name: "1 color"
          label: "1 Color"
          modifier: [
            {
              action: "multiply"
              value: 1.1
            }
            {
              action: "add"
              value: 35
            }
          ]
        }
        {
          name: "2 color"
          label: "2 Color"
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
      ]
    }
  ]
  modifier: [
    {
      action: "divide"
      value: 3
    }
    {
      action: "multiply"
      value: 4
    }
  ]

})
