# Dependencies
require 'ruby-freshbooks'
require 'yaml'
require 'ostruct'
require_relative 'config.local'

# Class Definitions
class FreshReports 
  
  def initialize
    @api = FreshBooks::Client.new('brightbit.freshbooks.com', Config.freshbooks_key)
    puts "FreshReports Initialized."
  end
  
  
  
  def get_income
  
   time = 0.0
  
    page = 1
    pages = 1
  
    until page.to_i > pages.to_i do  
      time_entries = @api.time_entry.list per_page: '100', page: page, date_from: "2012-01-01", date_to: "2012-12-31"
      entries = time_entries['time_entries']
      entry = entries['time_entry']
     
          entry.each do |e|
            hours = e
            hours = hours['hours']
            time = hours.to_f + time.to_f
          end
    
      pages = entries['pages']
      puts "Page: " + page.to_s
      page = page + 1
         
   end

  
  end
  
  
  def get_payments
    
    total = 0
    page = 1
    pages = 1
  
    until page.to_i > pages.to_i do
      p = @api.payment.list per_page: "100", page: page, date_from: "2012-01-01", date_to: "2012-12-31"
      payments = p['payments']
      payment = payments['payment']
    
        payment.each do |amount|
          amount = amount["amount"]
          puts amount
          total = amount.to_f + total.to_f
        end
      
    pages = payments['pages']
    page = page + 1
  
    end
    
    puts total
  
  end
  
end


#Script
manager = FreshReports.new
manager.get_payments
