//Copy this into Nilesoft Shell/imports/theme.nss
theme
{
	name = "tokyo-storm"

	view = view.compact

	background
	{
		color = #1f2335
		opacity = 100
		// effect = 2
	}

	item
	{
		opacity = 100
		radius = 10
		prefix = 1

		text
		{
			normal = #c0caf5
			select = #c0caf5
			normal-disabled = #a9b1d6
			select-disabled = #a9b1d6
		}

		back
		{
			select = #3b4261
			select-disabled = #3b4261
		}
	}

	font
        {
	 	size = 14
		name = "Segoe UI Variable Text"
          	weight = 2
	 	italic = 0
        }

	border
	{
		enabled = true
		size = 1
		color = #3b4261
		opacity = 100
		radius = 0
	}

	shadow
	{
		enabled = true
		size = 5
		opacity = 15
		color = #1f2335
	}

	separator
	{
		size = 1
		color = #3b4261
	}

	symbol
	{
		normal = #c0caf5
		select = #c0caf5
		normal-disabled = #3b4261
		select-disabled = #3b4261
	}

	image
	{
		enabled = true
		color = [#a9b1d6, #c0caf5, #1f2335]
	}
}
