var TwitterSearch = function(options) {
    this.resultsHandler = options.resultsHandler;
};

TwitterSearch.prototype = {

    parseResult: function(resultJSONText) {

        if (resultJSONText === '') {
            return;
        }

        var result = JSON.parse(resultJSONText);
        for (var tweetIndex in result.results) {
            if (typeof this.resultsHandler === 'function') {
                this.resultsHandler(result.results[tweetIndex]);
            }
        }
    },

    search: function(searchWord) {
        var that = this;
        var twitterSearchAPIURL = 'http://search.twitter.com/search.json?q=' + encodeURI(searchWord) + '&rpp=25&include_entities=true&result_type=recent';

        var oXHR = new XMLHttpRequest();
        oXHR.open('GET', twitterSearchAPIURL, true);
        oXHR.onreadystatechange = function (oEvent) {
            if (oXHR.readyState === 4) {
                if (oXHR.status === 200) {
                    that.parseResult(oXHR.responseText);
                } else {
                    console.log('Error', oXHR.statusText);
                }
            }
        };
        oXHR.send(null);
    }
};