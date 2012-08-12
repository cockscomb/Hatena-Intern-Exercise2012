var TwitterSearch = function() {};

TwitterSearch.prototype = {

    parseResult: function(result) {

        console.log(result);
        for (var tweetIndex in result.results) {
            if (typeof TwitterSearch.prototype.resultsHandler === 'function') {
                TwitterSearch.prototype.resultsHandler(result.results[tweetIndex]);
            }
        }
    },

    search: function(searchWord, resultsHandler) {
        var that = this;
        var twitterSearchAPIURL = 'http://search.twitter.com/search.json?q=' + encodeURI(searchWord) + '&rpp=25&include_entities=true&result_type=recent&callback=TwitterSearch.prototype.parseResult';
        TwitterSearch.prototype.resultsHandler = resultsHandler;

        var target = document.createElement('script');
        target.charset = 'utf-8';
        target.src = twitterSearchAPIURL;
        document.body.appendChild(target);
    }
};