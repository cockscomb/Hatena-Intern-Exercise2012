var main = function() {

    var source = document.getElementById('template').innerHTML;
    var template = new Template({
        source: source
    });

    document.getElementById('result').innerHTML = '';

    var twitterSearch = new TwitterSearch({
        callback: function(tweet) {
            console.log(tweet);

            document.getElementById('result').innerHTML = document.getElementById('result').innerHTML + template.render({
                from_user_name: tweet.from_user_name,
                profile_image_url: tweet.profile_image_url,
                text: tweet.text
            });
        }
    });
    twitterSearch.search('はてな');
};

document.addEventListener('DOMContentLoaded', main);