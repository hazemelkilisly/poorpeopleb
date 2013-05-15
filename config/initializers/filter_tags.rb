class String
  def filter_tags(array)
  	special = ".?!@<>',[]=-_)(*&^%$#`~{}0123456789"
	ans = (downcase.split - array).join(' ')
	for i in 0..(special.length-1)
		ans = ans.delete(special[i])
	end
	ans1 = ans.split
  end
end
