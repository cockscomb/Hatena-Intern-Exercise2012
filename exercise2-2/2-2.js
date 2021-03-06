var main = function() {

    var source = document.getElementById('template').innerHTML;
    var template = new Template({
        source: source
    });

    var twitterSearch = new TwitterSearch({
    });

    var searchField = document.getElementById('search_field');
    searchField.addEventListener('change', function(event) {
        document.getElementById('result').innerHTML = '';
        twitterSearch.search(searchField.value, function(tweet) {
            console.log(tweet);

            document.getElementById('result').innerHTML = document.getElementById('result').innerHTML + template.render({
                from_user_name: tweet.from_user_name,
                profile_image_url: tweet.profile_image_url,
                text: tweet.text,
                source_url: 'http://twitter.com/' + tweet.from_user + '/status/' + tweet.id_str,
                created_at: new Date(tweet.created_at).toLocaleString()
            });
        });
    });
};

document.addEventListener('DOMContentLoaded', main);