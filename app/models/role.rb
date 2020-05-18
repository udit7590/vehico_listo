class Role < ApplicationRecord
  module Type
    CUSTOMER    = 'Customer'.freeze
    SALES_REP   = 'SalesRep'.freeze
    TECHNICIAN  = 'Technician'.freeze
  end

  validates_presence_of :name

  class << self
    def user
      Role.find_by(name: Type::CUSTOMER)
    end

    def sales_rep
      Role.find_by(name: Type::SALES_REP)
    end

    def technician
      Role.find_by(name: Type::TECHNICIAN)
    end
  end
end
