const nunjucks = require('nunjucks')
const config = require('./config')

nunjucks.configure({
    autoescape: false,
    tags: {
        blockStart: '{{{%',
        blockEnd: '%}}}',
        variableStart: '{{{',
        variableEnd: '}}}',
        commentStart: '{{{#',
        commentEnd: '#}}}'
    }
})

module.exports = function (source) {
    const rendered = nunjucks.renderString(source, config)
    return rendered
}