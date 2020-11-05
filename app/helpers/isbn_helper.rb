module IsbnHelper
	ISBN_10 = /^(?:\d[\ |-]?){9}[\d|X]$/ 			# 1-234-56789-X or 1 234 56789 X or 123456789X
	NO_DASH_ISBN_10 = /^(?:\d?){9}[\d|X]$/  	# 123456789X only
	
	def isbn10?(isbn)
		if isbn.match(NO_DASH_ISBN_10)
			isbn = isbn.split('')
			check_digit = isbn.pop # check digit is last position
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

	def normalise(isbn)
		isbn.gsub(/[\ |-]/, '')
	end
end
