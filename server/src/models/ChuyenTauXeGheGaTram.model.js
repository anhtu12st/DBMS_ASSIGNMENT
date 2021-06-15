const createModel = require('../utils/model_helper');
const knex = require('../knex/knex');

const MODEL_NAME = 'ChuyenTauXeGheGaTram';
const TABLE_NAME = 'Chuyen_tau_xe_ghe_ga_tram';

const selectableProps = ['*'];

const ChuyenTauXeGheGaTram = (knex) => {
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

module.exports = ChuyenTauXeGheGaTram(knex);
