module Developers::DashboardHelper
  def full_date date
    date.strftime("%Y-%m-%d %H:%M")   
  end
end
