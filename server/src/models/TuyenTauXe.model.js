const createModel = require('../utils/model_helper');
const knex = require('../knex/knex');

const MODEL_NAME = 'TuyenTauXe';
const TABLE_NAME = 'Tuyen_tau_xe';

const selectableProps = ['*'];

const TuyenTauXe = (knex) => {
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

module.exports = TuyenTauXe(knex);
