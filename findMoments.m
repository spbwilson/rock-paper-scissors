function cuv = translationInvariant(u,v,mhi)

	rHat = 0;
	cHat = 0;
	cOfM = [rHat, cHat];
	area = bwarea(bwlabel(mhi));

	for row = 1 : size(mhi, 1)
		for col = 1 : size(mhi, 2)
			rHat = rHat + (row * mhi(row,col)) / area;
			cHat = cHat + (col * mhi(row,col)) / area;
		end
	end

	for row = 1 : size(mhi, 1)
		for col = 1 : size(mhi, 2)
			cuv = ((complex((row - rHat), (col - cHat)))^u) * ((complex((row - rHat), (col - cHat))^v) * mhi(row,col);
		end
	end
end
