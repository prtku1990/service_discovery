ServiceDiscovery::App.mailer :customer do
  email :welcome do |name, email_id|
    from 'manmeet.singh@flipkart.com'
    to email_id
    subject 'Welcome to TheOpenDoors'
    locals :name => name
    html_part render 'welcome'
  end
end