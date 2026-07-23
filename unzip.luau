--!strict
--!native
--!optimize 2

const LEN_BASE = buffer.fromstring("\3\0\4\0\5\0\6\0\7\0\8\0\9\0\10\0\11\0\13\0\15\0\17\0\19\0\23\0\27\0\31\0\35\0\43\0\51\0\59\0\67\0\83\0\99\0\115\0\131\0\163\0\195\0\227\0\2\1")
const LEN_EXTRA = buffer.fromstring("\0\0\0\0\0\0\0\0\1\1\1\1\2\2\2\2\3\3\3\3\4\4\4\4\5\5\5\5\0")

const DIST_BASE  = buffer.fromstring("\1\0\2\0\3\0\4\0\5\0\7\0\9\0\13\0\17\0\25\0\33\0\49\0\65\0\97\0\129\0\193\0\1\1\129\1\1\2\1\3\1\4\1\6\1\8\1\12\1\16\1\24\1\32\1\48\1\64\1\96")
const DIST_EXTRA = buffer.fromstring("\0\0\0\0\1\1\2\2\3\3\4\4\5\5\6\6\7\7\8\8\9\9\10\10\11\11\12\12\13\13")
const CL_ORDER = buffer.fromstring("\16\17\18\0\8\7\9\6\10\5\11\4\12\3\13\2\14\1\15")

const FIXED_LIT_LUT = buffer.fromstring("\0\1\7\0\80\0\8\0\16\0\8\0\24\1\8\0\16\1\7\0\112\0\8\0\48\0\8\0\192\0\9\0\8\1\7\0\96\0\8\0\32\0\8\0\160\0\9\0\0\0\8\0\128\0\8\0\64\0\8\0\224\0\9\0\4\1\7\0\88\0\8\0\24\0\8\0\144\0\9\0\20\1\7\0\120\0\8\0\56\0\8\0\208\0\9\0\12\1\7\0\104\0\8\0\40\0\8\0\176\0\9\0\8\0\8\0\136\0\8\0\72\0\8\0\240\0\9\0\2\1\7\0\84\0\8\0\20\0\8\0\28\1\8\0\18\1\7\0\116\0\8\0\52\0\8\0\200\0\9\0\10\1\7\0\100\0\8\0\36\0\8\0\168\0\9\0\4\0\8\0\132\0\8\0\68\0\8\0\232\0\9\0\6\1\7\0\92\0\8\0\28\0\8\0\152\0\9\0\22\1\7\0\124\0\8\0\60\0\8\0\216\0\9\0\14\1\7\0\108\0\8\0\44\0\8\0\184\0\9\0\12\0\8\0\140\0\8\0\76\0\8\0\248\0\9\0\1\1\7\0\82\0\8\0\18\0\8\0\26\1\8\0\17\1\7\0\114\0\8\0\50\0\8\0\196\0\9\0\9\1\7\0\98\0\8\0\34\0\8\0\164\0\9\0\2\0\8\0\130\0\8\0\66\0\8\0\228\0\9\0\5\1\7\0\90\0\8\0\26\0\8\0\148\0\9\0\21\1\7\0\122\0\8\0\58\0\8\0\212\0\9\0\13\1\7\0\106\0\8\0\42\0\8\0\180\0\9\0\10\0\8\0\138\0\8\0\74\0\8\0\244\0\9\0\3\1\7\0\86\0\8\0\22\0\8\0\30\1\8\0\19\1\7\0\118\0\8\0\54\0\8\0\204\0\9\0\11\1\7\0\102\0\8\0\38\0\8\0\172\0\9\0\6\0\8\0\134\0\8\0\70\0\8\0\236\0\9\0\7\1\7\0\94\0\8\0\30\0\8\0\156\0\9\0\23\1\7\0\126\0\8\0\62\0\8\0\220\0\9\0\15\1\7\0\110\0\8\0\46\0\8\0\188\0\9\0\14\0\8\0\142\0\8\0\78\0\8\0\252\0\9\0\0\1\7\0\81\0\8\0\17\0\8\0\25\1\8\0\16\1\7\0\113\0\8\0\49\0\8\0\194\0\9\0\8\1\7\0\97\0\8\0\33\0\8\0\162\0\9\0\1\0\8\0\129\0\8\0\65\0\8\0\226\0\9\0\4\1\7\0\89\0\8\0\25\0\8\0\146\0\9\0\20\1\7\0\121\0\8\0\57\0\8\0\210\0\9\0\12\1\7\0\105\0\8\0\41\0\8\0\178\0\9\0\9\0\8\0\137\0\8\0\73\0\8\0\242\0\9\0\2\1\7\0\85\0\8\0\21\0\8\0\29\1\8\0\18\1\7\0\117\0\8\0\53\0\8\0\202\0\9\0\10\1\7\0\101\0\8\0\37\0\8\0\170\0\9\0\5\0\8\0\133\0\8\0\69\0\8\0\234\0\9\0\6\1\7\0\93\0\8\0\29\0\8\0\154\0\9\0\22\1\7\0\125\0\8\0\61\0\8\0\218\0\9\0\14\1\7\0\109\0\8\0\45\0\8\0\186\0\9\0\13\0\8\0\141\0\8\0\77\0\8\0\250\0\9\0\1\1\7\0\83\0\8\0\19\0\8\0\27\1\8\0\17\1\7\0\115\0\8\0\51\0\8\0\198\0\9\0\9\1\7\0\99\0\8\0\35\0\8\0\166\0\9\0\3\0\8\0\131\0\8\0\67\0\8\0\230\0\9\0\5\1\7\0\91\0\8\0\27\0\8\0\150\0\9\0\21\1\7\0\123\0\8\0\59\0\8\0\214\0\9\0\13\1\7\0\107\0\8\0\43\0\8\0\182\0\9\0\11\0\8\0\139\0\8\0\75\0\8\0\246\0\9\0\3\1\7\0\87\0\8\0\23\0\8\0\31\1\8\0\19\1\7\0\119\0\8\0\55\0\8\0\206\0\9\0\11\1\7\0\103\0\8\0\39\0\8\0\174\0\9\0\7\0\8\0\135\0\8\0\71\0\8\0\238\0\9\0\7\1\7\0\95\0\8\0\31\0\8\0\158\0\9\0\23\1\7\0\127\0\8\0\63\0\8\0\222\0\9\0\15\1\7\0\111\0\8\0\47\0\8\0\190\0\9\0\15\0\8\0\143\0\8\0\79\0\8\0\254\0\9\0\0\1\7\0\80\0\8\0\16\0\8\0\24\1\8\0\16\1\7\0\112\0\8\0\48\0\8\0\193\0\9\0\8\1\7\0\96\0\8\0\32\0\8\0\161\0\9\0\0\0\8\0\128\0\8\0\64\0\8\0\225\0\9\0\4\1\7\0\88\0\8\0\24\0\8\0\145\0\9\0\20\1\7\0\120\0\8\0\56\0\8\0\209\0\9\0\12\1\7\0\104\0\8\0\40\0\8\0\177\0\9\0\8\0\8\0\136\0\8\0\72\0\8\0\241\0\9\0\2\1\7\0\84\0\8\0\20\0\8\0\28\1\8\0\18\1\7\0\116\0\8\0\52\0\8\0\201\0\9\0\10\1\7\0\100\0\8\0\36\0\8\0\169\0\9\0\4\0\8\0\132\0\8\0\68\0\8\0\233\0\9\0\6\1\7\0\92\0\8\0\28\0\8\0\153\0\9\0\22\1\7\0\124\0\8\0\60\0\8\0\217\0\9\0\14\1\7\0\108\0\8\0\44\0\8\0\185\0\9\0\12\0\8\0\140\0\8\0\76\0\8\0\249\0\9\0\1\1\7\0\82\0\8\0\18\0\8\0\26\1\8\0\17\1\7\0\114\0\8\0\50\0\8\0\197\0\9\0\9\1\7\0\98\0\8\0\34\0\8\0\165\0\9\0\2\0\8\0\130\0\8\0\66\0\8\0\229\0\9\0\5\1\7\0\90\0\8\0\26\0\8\0\149\0\9\0\21\1\7\0\122\0\8\0\58\0\8\0\213\0\9\0\13\1\7\0\106\0\8\0\42\0\8\0\181\0\9\0\10\0\8\0\138\0\8\0\74\0\8\0\245\0\9\0\3\1\7\0\86\0\8\0\22\0\8\0\30\1\8\0\19\1\7\0\118\0\8\0\54\0\8\0\205\0\9\0\11\1\7\0\102\0\8\0\38\0\8\0\173\0\9\0\6\0\8\0\134\0\8\0\70\0\8\0\237\0\9\0\7\1\7\0\94\0\8\0\30\0\8\0\157\0\9\0\23\1\7\0\126\0\8\0\62\0\8\0\221\0\9\0\15\1\7\0\110\0\8\0\46\0\8\0\189\0\9\0\14\0\8\0\142\0\8\0\78\0\8\0\253\0\9\0\0\1\7\0\81\0\8\0\17\0\8\0\25\1\8\0\16\1\7\0\113\0\8\0\49\0\8\0\195\0\9\0\8\1\7\0\97\0\8\0\33\0\8\0\163\0\9\0\1\0\8\0\129\0\8\0\65\0\8\0\227\0\9\0\4\1\7\0\89\0\8\0\25\0\8\0\147\0\9\0\20\1\7\0\121\0\8\0\57\0\8\0\211\0\9\0\12\1\7\0\105\0\8\0\41\0\8\0\179\0\9\0\9\0\8\0\137\0\8\0\73\0\8\0\243\0\9\0\2\1\7\0\85\0\8\0\21\0\8\0\29\1\8\0\18\1\7\0\117\0\8\0\53\0\8\0\203\0\9\0\10\1\7\0\101\0\8\0\37\0\8\0\171\0\9\0\5\0\8\0\133\0\8\0\69\0\8\0\235\0\9\0\6\1\7\0\93\0\8\0\29\0\8\0\155\0\9\0\22\1\7\0\125\0\8\0\61\0\8\0\219\0\9\0\14\1\7\0\109\0\8\0\45\0\8\0\187\0\9\0\13\0\8\0\141\0\8\0\77\0\8\0\251\0\9\0\1\1\7\0\83\0\8\0\19\0\8\0\27\1\8\0\17\1\7\0\115\0\8\0\51\0\8\0\199\0\9\0\9\1\7\0\99\0\8\0\35\0\8\0\167\0\9\0\3\0\8\0\131\0\8\0\67\0\8\0\231\0\9\0\5\1\7\0\91\0\8\0\27\0\8\0\151\0\9\0\21\1\7\0\123\0\8\0\59\0\8\0\215\0\9\0\13\1\7\0\107\0\8\0\43\0\8\0\183\0\9\0\11\0\8\0\139\0\8\0\75\0\8\0\247\0\9\0\3\1\7\0\87\0\8\0\23\0\8\0\31\1\8\0\19\1\7\0\119\0\8\0\55\0\8\0\207\0\9\0\11\1\7\0\103\0\8\0\39\0\8\0\175\0\9\0\7\0\8\0\135\0\8\0\71\0\8\0\239\0\9\0\7\1\7\0\95\0\8\0\31\0\8\0\159\0\9\0\23\1\7\0\127\0\8\0\63\0\8\0\223\0\9\0\15\1\7\0\111\0\8\0\47\0\8\0\191\0\9\0\15\0\8\0\143\0\8\0\79\0\8\0\255\0\9\0")
const FIXED_LIT_MAX = 9
const FIXED_DIST_LUT = buffer.fromstring("\0\0\5\0\16\0\5\0\8\0\5\0\24\0\5\0\4\0\5\0\20\0\5\0\12\0\5\0\28\0\5\0\2\0\5\0\18\0\5\0\10\0\5\0\26\0\5\0\6\0\5\0\22\0\5\0\14\0\5\0\0\0\0\0\1\0\5\0\17\0\5\0\9\0\5\0\25\0\5\0\5\0\5\0\21\0\5\0\13\0\5\0\29\0\5\0\3\0\5\0\19\0\5\0\11\0\5\0\27\0\5\0\7\0\5\0\23\0\5\0\15\0\5\0\0\0\0\0")
const FIXED_DIST_MAX = 5

const EOCD_START = 0x06054b50
const CD_ENTRY = 0x02014b50
const LOCAL_FILE_HEADER = 0x04034b50


@[native, checked] const function ReverseBits(v: number, n: number): number
	local Result = 0
	for _ = 1, n do
		Result = bit32.bor(Result * 2, bit32.band(v, 1))
		v //= 2
	end
	return Result
end



@[native, checked] const function BuildHuffman(Lens: buffer, Count: number): (buffer, number)
	const BLCount = buffer.create(64)
	local MaxLen = 0

	for i = 0, Count - 1 do
		const Length = buffer.readu8(Lens, i)
		if Length ~= 0 then
			local Offset = Length * 4
			buffer.writeu32(BLCount, Offset, buffer.readu32(BLCount, Offset) + 1)
			if Length > MaxLen then
				MaxLen = Length
			end
		end
	end

	if MaxLen == 0 then
		return buffer.create(4), MaxLen
	end

	const NextCode = buffer.create(64)
	local Code = 0
	for l = 1, MaxLen do
		Code = (Code + buffer.readu32(BLCount, (l - 1) * 4)) * 2
		buffer.writeu32(NextCode, l * 4, Code)
	end

	const Size = bit32.lshift(1, MaxLen)
	const Lut = buffer.create(Size * 4)

	for sym = 0, Count - 1 do
		const Length = buffer.readu8(Lens, sym)
		if Length ~= 0 then
			const Offset = Length * 4
			const Count = buffer.readu32(NextCode, Offset)
			buffer.writeu32(NextCode, Offset, Count + 1)

			const Key = ReverseBits(Count, Length)
			const Entry = bit32.bor(sym, Length * 65536)
			const Step = bit32.lshift(1, Length)
			for k = Key, Size - 1, Step do
				buffer.writeu32(Lut, k * 4, Entry)
			end
		end
	end

	return Lut, MaxLen
end

@[native, checked] const function Inflate(Source: buffer, SourceBitOffset: number, Destination: buffer, DestinationOffset: number): (number, number)
	local BitPos = SourceBitOffset
	local DestinationPos = DestinationOffset

	local Final = 0
	while Final == 0 do
		Final = buffer.readbits(Source, BitPos, 1)
		const BlockType = buffer.readbits(Source, BitPos + 1, 2)
		BitPos += 3

		if BlockType == 0 then
			BitPos = bit32.band(BitPos + 7, -8)
			const BytePos = BitPos // 8
			const BuffLen = buffer.readu16(Source, BytePos)
			buffer.copy(Destination, DestinationPos, Source, BytePos + 4, BuffLen)
			DestinationPos = DestinationPos + BuffLen
			BitPos = (BytePos + 4 + BuffLen) * 8

		elseif BlockType == 3 then
			error("Invalid block type")
		else
			local LitLut: buffer
			local LitMax: number
			local DistLut: buffer
			local DistMax: number

			if BlockType == 1 then
				LitLut, LitMax = FIXED_LIT_LUT, FIXED_LIT_MAX
				DistLut, DistMax = FIXED_DIST_LUT, FIXED_DIST_MAX
			else

				const HLit = buffer.readbits(Source, BitPos, 5) + 257
				const HDist = buffer.readbits(Source, BitPos + 5, 5) + 1
				const HCLen = buffer.readbits(Source, BitPos + 10, 4) + 4
				BitPos += 14


				const CLLens = buffer.create(19)
				for i = 0, HCLen - 1 do
					buffer.writeu8(CLLens, buffer.readu8(CL_ORDER, i), buffer.readbits(Source, BitPos, 3))
					BitPos += 3
				end

				const CLLut, CLMax = BuildHuffman(CLLens, 19)

				const Total = HLit + HDist
				const CodeLens = buffer.create(Total)
				do
					local i = 0
					while i < Total do
						const Bits = buffer.readbits(Source, BitPos, CLMax)
						const Entry = buffer.readu32(CLLut, Bits * 4)
						const Sym = bit32.band(Entry, 0xFFFF)
						BitPos += Entry // 65536

						if Sym < 16 then
							buffer.writeu8(CodeLens, i, Sym)
							i += 1
						elseif Sym == 16 then
							const Prev = buffer.readu8(CodeLens, i - 1)
							for _ = 1, buffer.readbits(Source, BitPos, 2) + 3 do
								buffer.writeu8(CodeLens, i, Prev)
								i += 1
							end
							BitPos += 2
						elseif Sym == 17 then
							i += buffer.readbits(Source, BitPos, 3) + 3
							BitPos += 3
						else
							i += buffer.readbits(Source, BitPos, 7) + 11
							BitPos += 7
						end
					end
				end

				const LitLens = buffer.create(HLit)
				buffer.copy(LitLens, 0, CodeLens, 0, HLit)
				LitLut, LitMax = BuildHuffman(LitLens, HLit)

				const DistLens = buffer.create(HDist)
				buffer.copy(DistLens, 0, CodeLens, HLit, HDist)
				DistLut, DistMax = BuildHuffman(DistLens, HDist)
			end

			while true do
				const Bits = buffer.readbits(Source, BitPos, LitMax)
				const Entry = buffer.readu32(LitLut, Bits * 4)
				const Sym = bit32.band(Entry, 0xFFFF)
				BitPos += Entry // 65536

				if Sym < 256 then
					buffer.writeu8(Destination, DestinationPos, Sym)
					DestinationPos += 1
				elseif Sym == 256 then
					break
				else
					const LenIndex = Sym - 257
					local Length = buffer.readu16(LEN_BASE, LenIndex * 2)
					const LenE = buffer.readu8(LEN_EXTRA, LenIndex)
					if LenE ~= 0 then
						Length += buffer.readbits(Source, BitPos, LenE)
						BitPos += LenE
					end

					const DistBits = buffer.readbits(Source, BitPos, DistMax)
					const DistEntry = buffer.readu32(DistLut, DistBits * 4)
					const DistSym = bit32.band(DistEntry, 0xFFFF)
					BitPos += DistEntry // 65536

					local Distance = buffer.readu16(DIST_BASE, DistSym * 2)
					const DistE = buffer.readu8(DIST_EXTRA, DistSym)
					if DistE ~= 0 then
						Distance += buffer.readbits(Source, BitPos, DistE)
						BitPos += DistE
					end

					const SPos = DestinationPos - Distance
					if Distance >= Length then
						buffer.copy(Destination, DestinationPos, Destination, SPos, Length)
						DestinationPos += Length
					else
						for i = 0, Length - 1 do
							buffer.writeu8(Destination, DestinationPos + i, buffer.readu8(Destination, SPos + i))
						end
						DestinationPos += Length
					end
				end
			end
		end
	end

	return BitPos, DestinationPos
end

@[native, checked] const function Unzip(Data: buffer): { [string]: buffer }
	const Size = buffer.len(Data)

	local EOCDPos = -1
	const MinPos = math.max(Size - 0x10015, 0)

	for i = Size - 22, MinPos, -1 do
		if buffer.readu32(Data, i) == EOCD_START then
			EOCDPos = i
			break
		end
	end

	if EOCDPos < 0 then
		error("EOCD not found")
	end

	const NumEntries = buffer.readu16(Data, EOCDPos + 10)
	local Position = buffer.readu32(Data, EOCDPos + 16)

	const Output = {}

	for _ = 1, NumEntries do
		if buffer.readu32(Data, Position) ~= CD_ENTRY then
			error("Invalid central directory entry")
		end

		const Method = buffer.readu16(Data, Position + 10)
		const CompressedSize = buffer.readu32(Data, Position + 20)
		const UnCompressedSize = buffer.readu32(Data, Position + 24)
		const NameLength = buffer.readu16(Data, Position + 28)
		const ExtraLength = buffer.readu16(Data, Position + 30)
		const CommentLength = buffer.readu16(Data, Position + 32)
		const LocalOffset = buffer.readu32(Data, Position + 42)
		const Index = buffer.readstring(Data, Position + 46, NameLength)

		if UnCompressedSize == 0xFFFFFFFF or CompressedSize == 0xFFFFFFFF then
			error("ZIP64 not supported")
		end

		if buffer.readu32(Data, LocalOffset) ~= LOCAL_FILE_HEADER then
			error("Invalid local file header")
		end

		const LHNameLength = buffer.readu16(Data, LocalOffset + 26)
		const LHExtraLength = buffer.readu16(Data, LocalOffset + 28)
		const DataStart = LocalOffset + 30 + LHNameLength + LHExtraLength

		const Value = buffer.create(UnCompressedSize)
		if Method == 0 then
			buffer.copy(Value, 0, Data, DataStart, CompressedSize)
		elseif Method == 8 then
			Inflate(Data, DataStart * 8, Value, 0)
		else
			error(`Unsupported compression method: {Method}`)
		end

		Output[Index] = Value

		Position += 46 + NameLength + ExtraLength + CommentLength
	end

	return Output
end

return Unzip
