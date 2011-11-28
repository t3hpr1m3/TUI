local addon, engine = ...

engine[1] = {} -- functions/constants
engine[2] = {} -- config

TUI = engine

local F, C = unpack(select(2, ...))
