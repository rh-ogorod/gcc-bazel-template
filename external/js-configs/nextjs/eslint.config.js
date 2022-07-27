// Hey Emacs, this is -*- coding: utf-8 -*-

const path = require('path');

const packageRoot = path.resolve(path.join(__dirname, '..'));

module.exports = {
  extends: [
    path.join(packageRoot, 'base/eslint.config'),
    'next/core-web-vitals',
    'plugin:react/jsx-runtime',
  ],
  rules: {
    // /b/; react
    // /b/{

    'react-hooks/exhaustive-deps': 'warn',
    'react-hooks/rules-of-hooks': 'error',
    'react/destructuring-assignment': 'off',
    'react/forbid-component-props': ['warn', { forbid: ['style'] }],
    'react/forbid-dom-props': ['warn', { forbid: ['style'] }],
    'react/jsx-filename-extension': [
      'error',
      {
        extensions: ['.tsx', '.jsx'],
      },
    ],
    'react/jsx-one-expression-per-line': 'off',
    'react/jsx-pascal-case': 'error',
    'react/jsx-props-no-spreading': 'off',
    'react/function-component-definition': [
      'error',
      {
        namedComponents: 'arrow-function',
        unnamedComponents: 'arrow-function',
      },
    ],

    // /b/}
  },
};
