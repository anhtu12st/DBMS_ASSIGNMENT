const createModel = require('../utils/model_helper');
const knex = require('../knex/knex');

const MODEL_NAME = 'USER';
const TABLE_NAME = 'user';

const selectableProps = ['*'];

const USER = (knex) => {
  const model = createModel({
    knex,
    name: MODEL_NAME,
    tableName: TABLE_NAME,
    selectableProps,
  });

  return {
    ...model,
  };
};

module.exports = USER(knex);
