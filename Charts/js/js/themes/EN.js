/**
 * Sand-Signika theme for Highcharts JS
 * @author Torstein Honsi
 */

 


// Load the fonts
Highcharts.createElement('link', {
	href: 'https://fonts.googleapis.com/css?family=Signika',
	rel: 'stylesheet',
	type: 'text/css'
}, null, document.getElementsByTagName('head')[0]);




Highcharts.theme = {
	colors: ["#f45b5b", "#8085e9", "#8d4654", "#7798BF", "#aaeeee", "#ff0066", "#eeaaee",
		"#55BF3B", "#DF5353", "#7798BF", "#aaeeee"],
	chart: {
		backgroundColor: null,
		style: {
			fontFamily: "sans-serif"
		}
	},
	title: {
		style: {
			color: 'darkgray',
			fontSize: '14px',
			fontWeight: 'bold'
		}
	},
	subtitle: {
		style: {
			color: 'darkgray',
			fontWeight: 'bold',
		 fontSize: '10px',
	}
	},
	tooltip: {
		style: {
			color: 'rgba(250, 250, 250, 0.5)',

		 fontSize: '10px',
	},
		borderWidth: 0,
		shadow: false,
		backgroundColor: 'rgba(0, 0, 0, 0)'
	},

	legend: {
		itemStyle: {
			fontFamily: "serif",
			fontWeight: 'bold',
			fontSize: '13px'
		}
	},
	xAxis: {
		labels: {
			style: {
				color: '#6e6e70'
			}
		}
	},
	yAxis: {
		labels: {
			style: {
				color: '#6e6e70'
			}
		}
	},
	plotOptions: {
		series: {
			shadow: true,

		},
		candlestick: {
			lineColor: '#404048'
		},
		map: {
			shadow: false
		}
	},

	// Highstock specific
	navigator: {
		xAxis: {
			gridLineColor: '#D0D0D8'
		}
	},
	rangeSelector: {
		buttonTheme: {
			fill: 'white',
			stroke: '#C0C0C8',
			'stroke-width': 1,
			states: {
				select: {
					fill: '#D0D0D8'
				}
			}
		}
	},
	scrollbar: {
		trackBorderColor: '#C0C0C8'
	},

	// General
	background2: '#E0E0E8'

};

// Apply the theme
Highcharts.setOptions(Highcharts.theme);
