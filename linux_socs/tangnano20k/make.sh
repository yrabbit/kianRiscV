#!/bin/sh -e
SRC_DIR=../kianv_harris_mcycle_edition/kianv_harris_edition
SRCS="${SRC_DIR}/design_elements.v ${SRC_DIR}/../soc.v ${SRC_DIR}/../gowin_rpll/gowin_rpll.v \
	  ${SRC_DIR}/../qqspi.v ${SRC_DIR}/../tx_uart.v ${SRC_DIR}/../rx_uart.v ${SRC_DIR}/../fifo.v \
	  ${SRC_DIR}/sdram/m12l64322a_ctrl.v ${SRC_DIR}/../bram.v ${SRC_DIR}/../clint.v \
	  ${SRC_DIR}/kianv_harris_mc_edition.v ${SRC_DIR}/control_unit.v ${SRC_DIR}/main_fsm.v \
	  ${SRC_DIR}/load_decoder.v ${SRC_DIR}/store_decoder.v ${SRC_DIR}/csr_decoder.v \
	  ${SRC_DIR}/alu_decoder.v ${SRC_DIR}/multiplier_extension_decoder.v ${SRC_DIR}/multiplier_decoer.v \
	  ${SRC_DIR}/divider_decoder.v ${SRC_DIR}/datapath_unit.v ${SRC_DIR}/register_file.v \
	  ${SRC_DIR}/extend.v ${SRC_DIR}/alu.v ${SRC_DIR}/csr_exception_handler.v"

yosys -p "read_verilog ${SRCS}; synth_gowin -json synth.json -family gw2a"
