//<!--
/*
 * NumberFormat 1.0.3
 * v1.0.3 - 23-March-2002
 * v1.0.2 - 13-March-2002
 * v1.0.1 - 20-July-2001
 * v1.0.0 - 13-April-2000
 * http://www.mredkj.com
 */
 
/*
 * NumberFormat -The constructor
 * num - The number to be formatted
 */
function NumberFormat(num)
{

	// member variables
	this.num;
	this.numOriginal;
	this.isCommas;
	this.isCurrency;
	this.currencyPrefix;
	this.places;

	// external methods
	this.setNumber = setNumberNF;
	this.toUnformatted = toUnformattedNF;
	this.setCommas = setCommasNF;
	this.setCurrency = setCurrencyNF;
	this.setCurrencyPrefix = setCurrencyPrefixNF;
	this.setPlaces = setPlacesNF;
	this.toFormatted = toFormattedNF;
	this.getOriginal = getOriginalNF;

	// internal methods
	this.getRounded = getRoundedNF;
	this.preserveZeros = preserveZerosNF;
	this.justNumber = justNumberNF;

	// setup defaults
	this.setNumber(num);
	this.setCommas(true);
	this.setCurrency(true);
	this.setCurrencyPrefix('');
	this.setPlaces(2);
}

/*
 * setNumber - Sets the number
 * num - The number to be formatted
 */
function setNumberNF(num)
{
	this.numOriginal = num;
	this.num = this.justNumber(num);
}

/*
 * toUnformatted - Returns the number as just a number.
 * If the original value was '100,000', then this method will return the number 100000
 * v1.0.2 - Modified comments, because this method no longer returns the original value.
 */
function toUnformattedNF()
{
	return (this.num);
}

/*
 * getOriginal - Returns the number as it was passed in, which may include non-number characters.
 * This function is new in v1.0.2
 */
function getOriginalNF()
{
	return (this.numOriginal);
}

/*
 * setCommas - Sets a switch that indicates if there should be commas
 * isC - true, if should be commas; false, if no commas
 */
function setCommasNF(isC)
{
	this.isCommas = isC;
}

/*
 * setCurrency - Sets a switch that indicates if should be displayed as currency
 * isC - true, if should be currency; false, if not currency
 */
function setCurrencyNF(isC)
{
	this.isCurrency = isC;
}

/*
 * setCurrencyPrefix - Sets the symbol that precedes currency.
 * cp - The symbol
 */
function setCurrencyPrefixNF(cp)
{
	this.currencyPrefix = cp;
}

/*
 * setPlaces - Sets the precision of decimal places
 * p - The number of places. Any number of places less than or equal to zero is considered zero.
 */
function setPlacesNF(p)
{
	this.places = p;
}

/*
 * toFormatted - Returns the number formatted according to the settings (a string)
 */
function toFormattedNF()
{
	var pos;
	var nNum = this.num; // v1.0.1 - number as a number
	var nStr;            // v1.0.1 - number as a string

	// round decimal places
	nNum = this.getRounded(nNum);
	nStr = this.preserveZeros(Math.abs(nNum)); // this step makes nNum into a string. v1.0.1 Math.abs

	if (this.isCommas)
	{
		pos = nStr.indexOf('.');
		if (pos == -1)
		{
			pos = nStr.length;
		}
		while (pos > 0)
		{
			pos -= 3;
			if (pos <= 0) break;
			nStr = nStr.substring(0,pos) + ',' + nStr.substring(pos, nStr.length);
		}
	}
	
	nStr = (nNum < 0) ? '-' + nStr : nStr; // v1.0.1

	if (this.isCurrency)
	{
		// add dollar sign in front
		nStr = this.currencyPrefix + nStr;
	}

	return (nStr);
}

/*
 * getRounded - Used internally to round a value
 * val - The number to be rounded
 */
function getRoundedNF(val)
{
	var factor;
	var i;

	// round to a certain precision
	factor = 1;
	for (i=0; i<this.places; i++)
	{	factor *= 10; }
	val *= factor;
	val = Math.round(val);
	val /= factor;

	return (val);
}

/*
 * preserveZeros - Used internally to make the number a string
 * 	that preserves zeros at the end of the number
 * val - The number
 */
function preserveZerosNF(val)
{
	var i;

	// make a string - to preserve the zeros at the end
	val = val + '';
	if (this.places <= 0) return val; // leave now. no zeros are necessary - v1.0.1 less than or equal
	
	var decimalPos = val.indexOf('.');
	if (decimalPos == -1)
	{
		val += '.';
		for (i=0; i<this.places; i++)
		{
			val += '0';
		}
	}
	else
	{
		var actualDecimals = (val.length - 1) - decimalPos;
		var difference = this.places - actualDecimals;
		for (i=0; i<difference; i++)
		{
			val += '0';
		}
	}
	
	return val;
}

/*
 * justNumber - Used internally to parse the value into a floating point number.
 * If the value is not set, then return 0.
 * If the value is not a number, then replace all characters that are not 0-9, a decimal point, or a negative sign.
 *
 *  Note: The regular expression cleans up the number, but doesn't get rid of - and .
 *  Because all negative signs and all decimal points are allowed,
 *  extra negative signs or decimal points may corrupt the result.
 *  parseFloat will ignore all values after any character that is NaN.
 *
 *  A number can be entered using special notation.
 *  For example, the following is a valid number: 0.0314E+2
 *
 * This function is new in v1.0.2
 */
function justNumberNF(val)
{
	val = (val==null) ? 0 : val;

	// check if a number, otherwise try taking out non-number characters.
	if (isNaN(val))
	{
		var newVal = parseFloat(val.replace(/[^\d\.\-]/g, ''));

		// check if still not a number. Might be undefined, '', etc., so just replace with 0.
		// v1.0.3
		return (isNaN(newVal) ? 0 : newVal); 
	}
	// return 0 in place of infinite numbers.
	// v1.0.3
	else if (!isFinite(val))
	{
		return 0;
  }
	
	return val;
}

//-->