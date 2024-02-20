class Company < ApplicationRecord

  def company_status
    if is_active == true
      "表示"
    else
      "非表示"
    end
  end

end
