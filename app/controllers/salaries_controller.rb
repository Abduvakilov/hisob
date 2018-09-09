class SalariesController < ApplicationController
  belongs_to :employee
  belongs_to :department
end
