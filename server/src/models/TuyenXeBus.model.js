const createModel = require("../utils/model_helper");
const knex = require("../knex/knex");

const TuyenTauXeModel = require("./TuyenTauXe.model");

const MODEL_NAME = "TuyenXeBus";
const TABLE_NAME = "Tuyen_xe_bus";

const selectableProps = ["*"];

const TuyenXeBus = (knex) => {
  const model = createModel({
    knex,
    name: MODEL_NAME,
    tableName: TABLE_NAME,
    selectableProps,
  });

  const addTuyenXeBus = async ({ ma_tuyen }) => {
    await TuyenTauXeModel.create({ ma_tuyen });
    return model.create({ ma_tuyen_tau_xe: ma_tuyen });
  };

  return {
    ...model,
    addTuyenXeBus,
  };
};

module.exports = TuyenXeBus(knex);
