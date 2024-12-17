PROJ=soc


RM             = rm -rf
VERILOG_FILES := pll.v \
								 bram.v \
								 tx_uart.v \
								 rx_uart.v \
								 fifo.v \
								 qqspi.v \
								 clint.v \
								 sdram/mt48lc16m16a2_ctrl.v \
								 kianv_harris_edition/kianv_harris_mc_edition.v \
								 kianv_harris_edition/control_unit.v  \
								 kianv_harris_edition/datapath_unit.v \
								 kianv_harris_edition/register_file.v \
								 kianv_harris_edition/design_elements.v \
								 kianv_harris_edition/alu.v \
								 kianv_harris_edition/main_fsm.v \
								 kianv_harris_edition/extend.v \
								 kianv_harris_edition/alu_decoder.v \
								 kianv_harris_edition/store_alignment.v \
								 kianv_harris_edition/store_decoder.v \
								 kianv_harris_edition/load_decoder.v \
								 kianv_harris_edition/load_alignment.v \
								 kianv_harris_edition/multiplier_extension_decoder.v \
								 kianv_harris_edition/divider.v \
								 kianv_harris_edition/multiplier.v \
								 kianv_harris_edition/divider_decoder.v \
								 kianv_harris_edition/multiplier_decoder.v \
								 kianv_harris_edition/csr_exception_handler.v \
								 kianv_harris_edition/csr_decoder.v

all: ${PROJ}.bit

%.json: %.v
	yosys -DULX3S -p "synth_gowin -family gw2a -json $@ -top ${PROJ}" ${VERILOG_FILES} $<

%_out.config: %.json
	nextpnr-ecp5  --timing-allow-fail --json $< --textcfg $@ --85k --package CABGA381 --lpf ulx3s_v20.lpf

%.bit: %_out.config
	#ecppack --compress --freq 125 --input $< --bit $@
	ecppack --compress --input $< --bit $@

sprog: ${PROJ}.bit
	fujprog $<

prog: ${PROJ}.bit
	fujprog -j flash $<

clean:
	$(RM) -f ${PROJ}.bit ${PROJ}_out.config ${PROJ}.json

#yosys -p "read_verilog ${SRCS}; synth_gowin -json synth.json -family gw2a"
