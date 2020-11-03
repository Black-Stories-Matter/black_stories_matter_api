module IsbnHelper
	def is_isbn10?(isbn)
		if isbn.match(/^(?:\d[\ |-]?){9}[\d|X]$/i)
			isbn = isbn.split('')
			check_digit = isbn.pop # last digit is check digit
	    check_digit = (check_digit.upcase == 'X') ? 10 : check_digit.to_i
			
			sum = 0
			isbn.each_with_index do |value, index|
				sum += (index + 1) * value.to_i
			end

			(sum % 11) == check_digit
		else
			false
		end
	end
end
