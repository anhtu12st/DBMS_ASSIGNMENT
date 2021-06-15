const createModel = require('../utils/model_helper');
const knex = require('../knex/knex');

const MODEL_NAME = 'GaTram';
const TABLE_NAME = 'Ga_tram';

const selectableProps = ['*'];

const GaTram = (knex) => {
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

module.exports = GaTram(knex);
