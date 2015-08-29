


sendEmail = (document) ->

  options = ""
  for option in document.options
    string = "
    <p>
      <strong>#{option.label}:</strong> #{option.value}
    </p>
    "
    options += string


  monthNames = [
    'January'
    'February'
    'March'
    'April'
    'May'
    'June'
    'July'
    'August'
    'September'
    'October'
    'November'
    'December'
  ]
  days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
  date = new Date
  hr = date.getHours()
  min = date.getMinutes()
  if min < 10
      min = "0" + min
  ampm = if hr < 12 then 'am' else 'pm'

  _date = date.getDate()
  day = days[date.getDay()]
  monthIndex = date.getMonth()
  month = monthNames[monthIndex]
  year = date.getFullYear()
  prettyDate = day + " " + hr + ":" + min + ampm + " " + _date + " " + month + " " + year
  # prettyDate = "#{monthNames[monthIndex]}, #{day}, #{year}"

  if document.product
    emailText = "
      <h1>Inquiry for a #{document.product.label}</h1>

      <div>

        <p>
          <em>
            The inquiry was sumbitted on #{prettyDate}
          </em>
        </p>

        <p>
          <h3>Quote Information</h3>
          <br>
          <br>

          Price: #{document.price}

        </p>

        #{options}

        <p>
          Description from client:
          <br>
          <br>
          #{document.description}
        </p>

        <h4>From #{document.name} at #{document.email}</h4>


      </div>
    "
  else
    emailText= "
      <h1>Message from #{document.name}</h1>

      <div>

        <p>
          <em>
            The inquiry was sumbitted on #{prettyDate}
          </em>
        </p>

        <p>
          Message from client:
          <br>
          <br>
          #{document.description}
        </p>

        <h4>From #{document.name} at #{document.email}</h4>


      </div>

    "

  Email.send({
    from: "admin@dapperink.com"
    to: "info@dapperink.com"
    subject: "Inquiry from #{document.email}"
    html: emailText
  })


started = false

Apollos.inquiries.find({}).observe({

  added: (doc) ->
    if started
      console.log "recieved inquery from #{doc.email}"

      sendEmail doc

})

started = true
