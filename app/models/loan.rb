class Loan < ActiveRecord::Base
  attr_accessible :amount, :rate, :term, :zip, :down, :appriciation, :fees, :zip

  before_validation do
    unless self.rate < 1 then self.rate = self.rate / 100 end
    unless self.down < 1 then self.down = self.down / 100 end
    unless self.appriciation < 1 then self.appriciation = self.appriciation / 100 end
  end
end
