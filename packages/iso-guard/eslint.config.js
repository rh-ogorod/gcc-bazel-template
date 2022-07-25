// Hey Emacs, this is -*- coding: utf-8 -*-

/* eslint-disable @typescript-eslint/no-var-requires */

const config = require('@ogorod/js-configs/base/eslint.config');

module.exports = {
  ...config,
  rules: {
    ...config.rules,
    'no-console': 'off',
  },
  settings: {
    ...config.settings,
    react: {
      version: 'detect',
    },
  },
};
