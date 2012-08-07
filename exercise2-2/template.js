var Template = function(input) {
    // この関数を実装してください
    this.templateString = input.source;
};

Template.prototype = {

    // Method for escaping html string
    escapedHTMLString: function(str) {
        return str.replace(/[&<>;]/g, function(char) {
            return {
                '&': '&amp;',
                '"': '&quot;',
                '<': '&lt;',
                '>': '&gt;'
            }[char];
        });
    },

    render: function(variables) {
        // この関数を実装してください

        var rendered = this.templateString;
        for (var key in variables) {
            if (variables.hasOwnProperty(key)) {
                // Get escaped value
                var value = variables[key];
                value = this.escapedHTMLString(value);

                // Replace placeholders
                var pattern = new RegExp('{%\\s+' + key + '\\s+%}', 'g');
                rendered = rendered.replace(pattern, value);
            }
        }

        return rendered;
    }
};