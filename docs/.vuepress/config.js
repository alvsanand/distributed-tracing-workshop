const path = require("path");

const urlPath = '/distributed-tracing-workshop';
const domain = 'https://alvsanand.github.io' + urlPath;
const title = 'Distributed Tracing Workshop';
const description = title;
const author = 'alvsanand';

module.exports = {
    title: title,
    description: title,
    base: urlPath + '/',
    head: [
        ['link', { rel: "icon", href: "/favicon.ico" }]
    ],
    themeConfig: {
        displayAllHeaders: true,
        lastUpdated: false,
        docsDir: 'docs',
        editLinks: false,
        domain: domain,
        logo: '/img/distributed-tracing_practice.png',
        nav: [
            { text: 'Home', link: '/' },
            {
                text: '@' + author,
                items: [
                    { text: 'Github', link: 'https://github.com/alvsanand' },
                    { text: 'LinekdIn', link: 'https://www.linkedin.com/in/alvsanand/' },
                ]
            },
            { text: 'Bluetab', link: 'https://bluetab.net/' },
            {
                text: 'Links',
                items: [
                    { text: 'OpenTracing', link: 'https://opentracing.io/docs/overview/' },
                    { text: 'Jaeger', link: 'https://www.jaegertracing.io/docs/latest' }
                ]
            }
        ],
        sidebar: [
            '/',
            '/technical_overview/',
            '/laboratory-01/',
            '/laboratory-02/',
            '/laboratory-03/',
        ]
    },
    plugins: [
        '@vuepress/medium-zoom',
        '@vuepress/back-to-top',
        'seo',
        'element-tabs'
    ],
    chainWebpack: config => {
        config.module
            .rule('md')
            .test(/\.md$/)
            .use(path.resolve(__dirname, './nunjucks'))
            .loader(path.resolve(__dirname, './nunjucks'))
            .end()
    },
}
