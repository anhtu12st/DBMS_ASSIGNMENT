const createModel = require("../utils/model_helper");
const knex = require("../knex/knex");
const ChuyenTauXeGheGaTramModel = require('./ChuyenTauXeGheGaTram.model');

const MODEL_NAME = "ChuyenTauXe";
const TABLE_NAME = "Chuyen_tau_xe";

const selectableProps = ["*"];

const ChuyenTauXe = (knex) => {
	const model = createModel({
		knex,
		name: MODEL_NAME,
		tableName: TABLE_NAME,
		selectableProps,
	});

  const addChuyenTauXe = async ({
    ma_tuyen,
    stt,
    ma_ga_tram,
    stt_ga_tram,
    gio_ghe,
    gio_di,
  }) => {
    let data = null;
    try {
      data = await model.create({ ma_tuyen, stt });
    } catch (error) {
    } finally {
      await ChuyenTauXeGheGaTramModel.create({
        ma_tuyen,
        stt_tuyen: stt,
        ma_ga_tram,
        stt: stt_ga_tram,
        gio_ghe,
        gio_di,
      });
    }
    return data;
  };

  const getAllWithGaTram = async () =>
    knex(`${TABLE_NAME} as C`)
      .join('Chuyen_tau_xe_ghe_ga_tram as D', function () {
        this.on(function () {
          this.on('C.ma_tuyen', '=', 'D.ma_tuyen')
          this.andOn('C.stt', '=', 'D.stt_tuyen')
        })
      })
      .select('*');

	return {
		...model,
    addChuyenTauXe,
    getAllWithGaTram,
	};
};

module.exports = ChuyenTauXe(knex);
