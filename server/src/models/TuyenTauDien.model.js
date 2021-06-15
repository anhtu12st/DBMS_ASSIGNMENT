const createModel = require('../utils/model_helper');
const knex = require('../knex/knex');
const TuyenTauXeModel = require('./TuyenTauXe.model');

const MODEL_NAME = 'TuyenTauDien';
const TABLE_NAME = 'Tuyen_tau_dien';

const selectableProps = ['*'];

const TuyenTauDien = (knex) => {
  const model = createModel({
    knex,
    name: MODEL_NAME,
    tableName: TABLE_NAME,
    selectableProps,
  });

  const addTuyenTauDien = async ({
    ma_tuyen_tau,
    ten_tuyen_tau,
    ma_tuyen_tau_xe,
  }) => {
    await TuyenTauXeModel.create({ ma_tuyen: ma_tuyen_tau_xe });
    return model.create({
      ma_tuyen_tau,
      ten_tuyen_tau,
      ma_tuyen_tau_xe,
    });
  };

  return {
    ...model,
    addTuyenTauDien,
  };
};

module.exports = TuyenTauDien(knex);
