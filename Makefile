
PROTOBUF_VER=latest
PROTOBUF_IMG=znly/protoc:$(PROTOBUF_VER)
PROTOBUF=docker run --rm -v $(PWD):$(PWD) -w $(PWD) $(PROTOBUF_IMG)

PROTOBUF_GEN=--python_out=build \
	--ruby_out=build \
	--go_out=build

PROTOBUF_CMD=$(PROTOBUF) --proto_path=src $(PROTOBUF_GEN)

PROTOBUF_FILES=foo.proto event.proto

install:
	npm install protobufjs -g

clean:
	rm -Rf build/*

protobuf: protobuf-image clean $(PROTOBUF_FILES)

$(PROTOBUF_FILES):
	@echo Compiling $@
	$(PROTOBUF_CMD) src/$@

protobuf-image:
	docker pull $(PROTOBUF_IMG)
	$(PROTOBUF) --version

.PHONY: protobuf protobuf-image $(PROTOBUF_FILES)
