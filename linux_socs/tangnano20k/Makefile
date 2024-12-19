PROJ=soc


RM            := rm -rf
SRC_DIR       := ../kianv_harris_mcycle_edition/kianv_harris_edition
VERILOG_FILES := src/gowin_rpll/gowin_rpll.v \
								 ${SRC_DIR}/../soc.v \
								 ${SRC_DIR}/../tx_uart.v \
								 ${SRC_DIR}/../rx_uart.v \
								 ${SRC_DIR}/../fifo.v \
								 ${SRC_DIR}/../qqspi.v \
								 ${SRC_DIR}/../clint.v \
								 ${SRC_DIR}/../bram.v \
								 ${SRC_DIR}/../sdram/m12l64322a_ctrl.v \
								 ${SRC_DIR}/kianv_harris_mc_edition.v \
								 ${SRC_DIR}/control_unit.v  \
								 ${SRC_DIR}/datapath_unit.v \
								 ${SRC_DIR}/register_file.v \
								 ${SRC_DIR}/design_elements.v \
								 ${SRC_DIR}/alu.v \
								 ${SRC_DIR}/main_fsm.v \
								 ${SRC_DIR}/extend.v \
								 ${SRC_DIR}/alu_decoder.v \
								 ${SRC_DIR}/store_alignment.v \
								 ${SRC_DIR}/store_decoder.v \
								 ${SRC_DIR}/load_decoder.v \
								 ${SRC_DIR}/load_alignment.v \
								 ${SRC_DIR}/multiplier_extension_decoder.v \
								 ${SRC_DIR}/divider.v \
								 ${SRC_DIR}/multiplier.v \
								 ${SRC_DIR}/divider_decoder.v \
								 ${SRC_DIR}/multiplier_decoder.v \
								 ${SRC_DIR}/csr_exception_handler.v \
								 ${SRC_DIR}/csr_decoder.v

all: ${PROJ}.bit

${PROJ}.json: ${VERILOG_FILES}
	yosys -p "read_verilog ${VERILOG_FILES}; synth_gowin -family gw2a -json $@ -top ${PROJ}"

%_out.config: %.json
	nextpnr-himbaechel --json $< --write $@ --device GW2AR-LV18QN88C8/I7 --vopt family=GW2A-18C --vopt cst=../kianv_harris_mcycle_edition/tangnano20k.cst

%.bit: %_out.config
	gowin_pack -d GW2A-18C -o $@ $<

sprog: ${PROJ}.bit
	#

prog: ${PROJ}.bit
	openFPGALoader -f --board=tangnano20k --external-flash -r $<

clean:
	$(RM) -f ${PROJ}.bit ${PROJ}_out.config ${PROJ}.json

