class DateFormatValidator < ActiveModel::EachValidator

  def validate_each(object, attribute, value)
    unless value.kind_of?(DateTime) || value.kind_of?(Time) || (DateTime.parse(value) rescue ArgumentError) != ArgumentError || (Time.parse(value) rescue ArgumentError) != ArgumentError
      object.errors[attribute] << (options[:message] || "is not valid datetime")
    end
  end

end