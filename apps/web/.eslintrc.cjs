module.exports = {
  extends: ['eslint-config-code9'],
  overrides: [
    {
      files: ['**/*.ts'],
      parserOptions: {
        project: [`${__dirname}/tsconfig.json`],
      },
    },
    {
      files: ['**/*.tsx'],
      parserOptions: {
        project: [`${__dirname}/tsconfig.json`],
      },
      rules: {
        '@typescript-eslint/comma-dangle': ['off'],
      },
    },
  ],
}
