
const path = require("path");

module.exports = {
    title: "Distributed Tracing Workshop ",
    description: "Distributed Tracing Workshop ",
    base: '/distributed-tracing-workshop/',
    head: [
        ['link', { rel: "icon", href: "/favicon.ico" }]
    ],
    themeConfig: {
        displayAllHeaders: true,
        lastUpdated: false,
        repo: 'https://github.com/alvsanand/distributed-tracing-workshop',
        docsDir: 'docs',
        editLinks: false,
        logo: '/img/distributed-tracing_practice.png',
        nav: [
            { text: 'Home', link: '/' },
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
