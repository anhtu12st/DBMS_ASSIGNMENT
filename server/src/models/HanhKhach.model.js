const createModel = require('../utils/model_helper');
const knex = require('../knex/knex');

const MODEL_NAME = 'HanhKhach';
const TABLE_NAME = 'Hanh_khach';

const selectableProps = ['*'];

const HanhKhach = (knex) => {
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

module.exports = HanhKhach(knex);
