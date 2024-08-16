	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 18, 4
	.file	"matrixDiagV7.c"
	.global	__aeabi_i2d
	.global	__aeabi_dcmpeq
	.text
	.align	2
	.global	checkOffDiagonalZeros
	.type	checkOffDiagonalZeros, %function
checkOffDiagonalZeros:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	subs	r6, r0, #0
	movgt	r7, r1
	movgt	r8, r6, asl #2
	movgt	r5, #0
	ble	.L2
.L3:
	mov	r4, #0
.L6:
	cmp	r5, r4
	beq	.L4
	ldr	r0, [r7, r4, asl #2]
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r3, #0
	bl	__aeabi_dcmpeq
	cmp	r0, #0
	beq	.L5
.L4:
	add	r4, r4, #1
	cmp	r6, r4
	bgt	.L6
	add	r5, r5, #1
	cmp	r6, r5
	add	r7, r7, r8
	bgt	.L3
.L2:
	mov	r0, #1
	b	.L7
.L5:
	mov	r0, #0
.L7:
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	bx	lr
	.size	checkOffDiagonalZeros, .-checkOffDiagonalZeros
	.align	2
	.global	matrixMultiply
	.type	matrixMultiply, %function
matrixMultiply:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 192
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	add	r3, r1, #16
	sub	sp, sp, #192
	str	r3, [sp, #120]
	add	r3, r1, #32
	str	r3, [sp, #124]
	add	r3, r1, #48
	str	r3, [sp, #116]
	ldr	r3, [r1, #16]
	str	r3, [sp, #48]
	ldr	r3, [r1, #0]
	str	r3, [sp, #16]
	ldr	r3, [r1, #32]
	str	r3, [sp, #56]
	ldr	r3, [r1, #48]
	str	r3, [sp, #24]
	ldr	r3, [sp, #120]
	ldr	r3, [r3, #4]
	str	r3, [sp, #52]
	ldr	r3, [r1, #4]
	str	r3, [sp, #20]
	ldr	r3, [sp, #124]
	ldr	r3, [r3, #4]
	str	r3, [sp, #60]
	ldr	r3, [sp, #116]
	ldr	r3, [r3, #4]
	str	r3, [sp, #32]
	ldr	r3, [sp, #120]
	ldr	r3, [r3, #8]
	str	r3, [sp, #40]
	ldr	r3, [r1, #8]
	str	r3, [sp, #8]
	ldr	r3, [sp, #124]
	ldr	r3, [r3, #8]
	str	r3, [sp, #44]
	ldr	r3, [sp, #116]
	ldr	r3, [r3, #8]
	str	r3, [sp, #12]
	ldr	r3, [sp, #120]
	ldr	r3, [r3, #12]
	str	r3, [sp, #28]
	ldr	r3, [r1, #12]
	str	r3, [sp, #0]
	ldr	r3, [sp, #124]
	ldr	r3, [r3, #12]
	str	r3, [sp, #36]
	ldr	r3, [sp, #116]
	ldr	r3, [r3, #12]
	str	r2, [sp, #112]
	str	r3, [sp, #4]
	mov	fp, r1
	mov	r9, r0
	mov	sl, r0
	add	r8, sp, #128
.L12:
	ldr	r3, [sl, #0]
	ldr	r1, [sp, #0]
	ldr	r0, [sp, #16]
	mul	r1, r3, r1
	mul	r0, r3, r0
	ldr	ip, [sp, #20]
	ldr	r4, [sp, #8]
	mul	ip, r3, ip
	mul	r4, r3, r4
	ldr	r2, [sl, #4]
	ldr	r5, [sp, #28]
	ldr	r6, [sp, #48]
	mla	r5, r2, r5, r1
	mla	r6, r2, r6, r0
	ldr	r1, [sp, #52]
	ldr	r0, [sp, #40]
	mla	r1, r2, r1, ip
	mla	r0, r2, r0, r4
	ldr	r3, [sl, #8]
	ldr	ip, [sp, #36]
	ldr	r4, [sp, #56]
	mla	ip, r3, ip, r5
	mla	r4, r3, r4, r6
	ldr	r5, [sp, #60]
	ldr	r6, [sp, #44]
	mla	r5, r3, r5, r1
	mla	r6, r3, r6, r0
	ldr	r2, [sl, #12]
	ldr	r7, [sp, #4]
	ldr	r3, [sp, #24]
	ldr	r1, [sp, #32]
	ldr	r0, [sp, #12]
	mla	r7, r2, r7, ip
	mla	r3, r2, r3, r4
	mla	r1, r2, r1, r5
	mla	r0, r2, r0, r6
	str	r3, [r8, #0]
	str	r1, [r8, #4]
	str	r0, [r8, #8]
	str	r7, [r8, #12]
	add	r2, sp, #192
	add	r8, r8, #16
	cmp	r8, r2
	add	sl, sl, #16
	bne	.L12
	ldr	r3, [sp, #112]
	cmp	r3, #0
	beq	.L13
	add	r2, sp, #148
	ldmia	r2, {r2, r3}	@ phole ldm
	str	r3, [sp, #104]
	ldr	r3, [sp, #168]
	str	r2, [sp, #108]
	ldr	r2, [sp, #164]
	str	r3, [sp, #96]
	ldr	r3, [sp, #180]
	str	r2, [sp, #100]
	ldr	r2, [sp, #176]
	str	r3, [sp, #88]
	ldr	r3, [sp, #128]
	str	r2, [sp, #92]
	ldr	r2, [sp, #184]
	ldr	r4, [sp, #172]
	ldr	r5, [sp, #188]
	add	r6, sp, #132
	ldmia	r6, {r6, r7, r8, sl}	@ phole ldm
	ldr	ip, [sp, #156]
	ldr	fp, [sp, #160]
	str	r3, [r9, #0]
	ldr	r3, [sp, #108]
	str	r2, [sp, #84]
	add	r2, r9, #16
	stmib	r9, {r6, r7, r8, sl}	@ phole stm
	str	r3, [r2, #4]
	ldr	r3, [sp, #104]
	str	ip, [r2, #12]
	str	r3, [r2, #8]
	str	fp, [r9, #32]
	ldr	r2, [sp, #100]
	add	r1, r9, #32
	str	r2, [r1, #4]
	add	r2, sp, #92
	ldmia	r2, {r2, r3}	@ phole ldm
	str	r3, [r1, #8]
	str	r4, [r1, #12]
	ldr	r3, [sp, #88]
	str	r2, [r9, #48]
	ldr	r2, [sp, #84]
	add	r0, r9, #48
	str	r5, [r0, #12]
	str	r3, [r0, #4]
	str	r2, [r0, #8]
.L15:
	add	sp, sp, #192
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	bx	lr
.L13:
	ldr	r3, [sp, #152]
	str	r3, [sp, #80]
	ldr	r3, [sp, #164]
	str	r3, [sp, #76]
	ldr	r3, [sp, #168]
	str	r3, [sp, #72]
	ldr	r3, [sp, #180]
	str	r3, [sp, #68]
	ldr	r3, [sp, #184]
	str	r3, [sp, #64]
	ldr	r3, [sp, #128]
	ldr	r2, [sp, #156]
	ldr	r8, [sp, #176]
	ldr	r0, [sp, #188]
	ldr	ip, [sp, #132]
	add	r4, sp, #136
	ldmia	r4, {r4, r5, r6, sl}	@ phole ldm
	ldr	r7, [sp, #160]
	ldr	r1, [sp, #172]
	str	r3, [fp, #0]
	ldr	r3, [sp, #120]
	str	ip, [fp, #4]
	str	r4, [fp, #8]
	str	r5, [fp, #12]
	str	r6, [fp, #16]
	str	r2, [r3, #12]
	ldr	r2, [sp, #80]
	str	sl, [r3, #4]
	str	r2, [r3, #8]
	ldr	r3, [sp, #124]
	str	r7, [fp, #32]
	str	r1, [r3, #12]
	ldr	r2, [sp, #76]
	str	r2, [r3, #4]
	ldr	r2, [sp, #72]
	str	r2, [r3, #8]
	ldr	r3, [sp, #116]
	ldr	r2, [sp, #68]
	str	r8, [fp, #48]
	str	r2, [r3, #4]
	ldr	r2, [sp, #64]
	str	r0, [r3, #12]
	str	r2, [r3, #8]
	b	.L15
	.size	matrixMultiply, .-matrixMultiply
	.align	2
	.global	multiplyWithTransposed
	.type	multiplyWithTransposed, %function
multiplyWithTransposed:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 160
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	ldr	r3, [r1, #4]
	sub	sp, sp, #160
	ldr	r5, [r1, #0]
	add	r7, r1, #8
	ldmia	r7, {r7, sl}	@ phole ldm
	str	r2, [sp, #84]
	add	ip, r1, #32
	add	r2, r1, #48
	str	r1, [sp, #88]
	str	r0, [sp, #92]
	str	r3, [sp, #28]
	str	r5, [sp, #24]
	str	r7, [sp, #16]
	str	ip, [sp, #32]
	str	r2, [sp, #20]
	str	sl, [sp, #12]
	mov	fp, r0
	add	r9, sp, #96
	add	sl, r1, #16
.L18:
	ldr	r2, [fp, #0]
	ldr	r1, [sl, #0]
	mul	r4, r1, r2
	ldr	r3, [sp, #32]
	ldr	r5, [sp, #20]
	ldr	r0, [r3, #0]
	ldr	r6, [sp, #24]
	ldr	r3, [r5, #0]
	ldr	r1, [fp, #4]
	mul	ip, r3, r2
	mul	r5, r0, r2
	mul	r6, r2, r6
	ldr	r2, [sl, #4]
	mla	r8, r2, r1, r4
	ldr	r7, [sp, #32]
	ldr	r0, [r7, #4]
	ldr	r7, [sp, #20]
	ldr	r4, [sp, #28]
	ldr	r3, [r7, #4]
	ldr	r2, [fp, #8]
	mla	r7, r3, r1, ip
	mla	r4, r1, r4, r6
	mla	ip, r0, r1, r5
	ldr	r1, [sl, #8]
	mla	r8, r1, r2, r8
	ldr	r5, [sp, #20]
	ldr	r3, [sp, #32]
	ldr	r0, [r3, #8]
	ldr	r3, [r5, #8]
	str	r8, [sp, #80]
	mla	r6, r3, r2, r7
	ldr	r8, [sp, #16]
	mla	r7, r0, r2, ip
	mla	r8, r2, r8, r4
	ldr	r1, [fp, #12]
	ldr	r3, [r5, #12]
	ldr	r2, [sp, #32]
	ldr	r0, [sl, #12]
	ldr	ip, [r2, #12]
	mla	r5, r3, r1, r6
	ldr	r2, [sp, #80]
	ldr	r3, [sp, #12]
	mla	r2, r0, r1, r2
	mla	r3, r1, r3, r8
	mla	r4, ip, r1, r7
	str	r3, [r9, #0]
	stmib	r9, {r2, r4, r5}	@ phole stm
	add	r3, sp, #160
	add	r9, r9, #16
	cmp	r9, r3
	add	fp, fp, #16
	bne	.L18
	ldr	r5, [sp, #84]
	cmp	r5, #0
	beq	.L19
	ldr	sl, [sp, #116]
	add	r2, sp, #132
	ldmia	r2, {r2, r3}	@ phole ldm
	ldr	ip, [sp, #120]
	str	sl, [sp, #76]
	str	r2, [sp, #68]
	ldr	sl, [sp, #148]
	ldr	r2, [sp, #152]
	str	r3, [sp, #64]
	ldr	r3, [sp, #92]
	ldr	r5, [sp, #144]
	add	r6, sp, #100
	ldmia	r6, {r6, r7, r8, fp}	@ phole ldm
	add	r1, r3, #32
	add	r0, r3, #48
	str	ip, [sp, #72]
	str	sl, [sp, #56]
	ldr	ip, [sp, #124]
	ldr	sl, [sp, #92]
	str	r2, [sp, #52]
	add	r2, r3, #16
	ldr	r3, [sp, #96]
	ldr	r9, [sp, #128]
	ldr	r4, [sp, #140]
	str	r5, [sp, #60]
	ldr	r5, [sp, #156]
	stmia	sl, {r3, r6, r7, r8}	@ phole stm
	str	fp, [sl, #16]
	ldr	r3, [sp, #72]
	str	ip, [r2, #12]
	ldr	ip, [sp, #76]
	str	ip, [r2, #4]
	str	r3, [r2, #8]
	str	r9, [sl, #32]
	ldr	r7, [sp, #68]
	add	r2, sp, #60
	ldmia	r2, {r2, sl}	@ phole ldm
	ldr	ip, [sp, #92]
	str	r4, [r1, #12]
	stmib	r1, {r7, sl}	@ phole stm
	ldr	r3, [sp, #56]
	str	r2, [ip, #48]
	str	r5, [r0, #12]
	ldr	r5, [sp, #52]
	stmib	r0, {r3, r5}	@ phole stm
.L21:
	add	sp, sp, #160
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	bx	lr
.L19:
	add	r2, sp, #132
	ldmia	r2, {r2, r3}	@ phole ldm
	str	r2, [sp, #48]
	ldr	r2, [sp, #148]
	ldr	r7, [sp, #124]
	ldr	r5, [sp, #108]
	str	r3, [sp, #44]
	str	r2, [sp, #40]
	ldr	r3, [sp, #152]
	ldr	r2, [sp, #88]
	str	r7, [sp, #4]
	ldr	ip, [sp, #100]
	ldr	r7, [sp, #128]
	ldr	r8, [sp, #144]
	ldr	r0, [sp, #156]
	ldr	r4, [sp, #104]
	add	r6, sp, #112
	ldmia	r6, {r6, fp}	@ phole ldm
	ldr	r9, [sp, #120]
	ldr	r1, [sp, #140]
	str	r3, [sp, #36]
	ldr	r3, [sp, #96]
	str	r5, [r2, #12]
	ldr	r5, [sp, #4]
	stmia	r2, {r3, ip}	@ phole stm
	str	r4, [r2, #8]
	str	r6, [r2, #16]
	str	r5, [sl, #12]
	str	fp, [sl, #4]
	str	r9, [sl, #8]
	str	r7, [r2, #32]
	ldr	r7, [sp, #32]
	str	r1, [r7, #12]
	ldr	sl, [sp, #48]
	ldr	ip, [sp, #44]
	stmib	r7, {sl, ip}	@ phole stm
	ldr	r3, [sp, #40]
	str	r8, [r2, #48]
	ldr	r5, [sp, #36]
	ldr	r2, [sp, #20]
	str	r0, [r2, #12]
	stmib	r2, {r3, r5}	@ phole stm
	b	.L21
	.size	multiplyWithTransposed, .-multiplyWithTransposed
	.align	2
	.global	apply_to_fixed_in_place
	.type	apply_to_fixed_in_place, %function
apply_to_fixed_in_place:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r0, #0]
	mov	ip, #262144
	sub	ip, ip, #1
	ldr	r2, [r0, #4]
	ldr	r1, [r0, #8]
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl}
	cmp	r3, #0
	add	r6, r3, ip
	ldr	r4, [r0, #12]
	add	r7, r2, ip
	movlt	r3, r6
	cmp	r2, #0
	ldr	r5, [r0, #16]
	add	r8, r1, ip
	movlt	r2, r7
	cmp	r1, #0
	add	sl, r4, ip
	movlt	r1, r8
	cmp	r4, #0
	add	r9, r5, ip
	movlt	r4, sl
	cmp	r5, #0
	movlt	r5, r9
	mov	r3, r3, asr #18
	mov	r2, r2, asr #18
	mov	r1, r1, asr #18
	mov	r4, r4, asr #18
	mov	r5, r5, asr #18
	str	r4, [r0, #12]
	str	r2, [r0, #4]
	str	r1, [r0, #8]
	str	r5, [r0, #16]
	str	r3, [r0, #0]
	add	r4, r0, #16
	ldr	r2, [r4, #4]
	add	r1, r4, #8
	ldmia	r1, {r1, r3}	@ phole ldm
	add	r5, r2, ip
	cmp	r2, #0
	add	r6, r1, ip
	movlt	r2, r5
	cmp	r1, #0
	add	r7, r3, ip
	movlt	r1, r6
	cmp	r3, #0
	movlt	r3, r7
	mov	r2, r2, asr #18
	mov	r1, r1, asr #18
	mov	r3, r3, asr #18
	str	r2, [r4, #4]
	str	r3, [r4, #12]
	str	r1, [r4, #8]
	ldr	r3, [r0, #32]
	add	r2, r3, ip
	cmp	r3, #0
	movlt	r3, r2
	mov	r3, r3, asr #18
	str	r3, [r0, #32]
	add	r4, r0, #32
	ldr	r2, [r4, #4]
	add	r1, r4, #8
	ldmia	r1, {r1, r3}	@ phole ldm
	add	r5, r2, ip
	cmp	r2, #0
	add	r6, r1, ip
	movlt	r2, r5
	cmp	r1, #0
	add	r7, r3, ip
	movlt	r1, r6
	cmp	r3, #0
	movlt	r3, r7
	mov	r2, r2, asr #18
	mov	r1, r1, asr #18
	mov	r3, r3, asr #18
	str	r2, [r4, #4]
	str	r3, [r4, #12]
	str	r1, [r4, #8]
	ldr	r3, [r0, #48]
	add	r2, r3, ip
	cmp	r3, #0
	movlt	r3, r2
	mov	r3, r3, asr #18
	str	r3, [r0, #48]
	add	r0, r0, #48
	ldr	r2, [r0, #4]
	add	r1, r0, #8
	ldmia	r1, {r1, r3}	@ phole ldm
	add	r4, r2, ip
	cmp	r2, #0
	add	r5, r3, ip
	movlt	r2, r4
	add	ip, r1, ip
	cmp	r1, #0
	movlt	r1, ip
	cmp	r3, #0
	movlt	r3, r5
	mov	r2, r2, asr #18
	mov	r1, r1, asr #18
	mov	r3, r3, asr #18
	str	r3, [r0, #12]
	str	r2, [r0, #4]
	str	r1, [r0, #8]
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl}
	bx	lr
	.size	apply_to_fixed_in_place, .-apply_to_fixed_in_place
	.align	2
	.global	printMatrixArray
	.type	printMatrixArray, %function
printMatrixArray:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	subs	r6, r0, #0
	movgt	r5, r1
	movgt	r8, r6, asl #2
	movgt	r7, #0
	ble	.L29
.L27:
	mov	r4, #0
.L28:
	ldr	r1, [r5, r4, asl #2]
	ldr	r0, .L31
	add	r4, r4, #1
	bl	printf
	cmp	r6, r4
	bgt	.L28
	add	r7, r7, #1
	mov	r0, #10
	bl	putchar
	cmp	r6, r7
	add	r5, r5, r8
	bgt	.L27
.L29:
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	bx	lr
.L32:
	.align	2
.L31:
	.word	.LC0
	.size	printMatrixArray, .-printMatrixArray
	.global	__aeabi_i2f
	.global	__aeabi_fdiv
	.global	__aeabi_fsub
	.global	__aeabi_fmul
	.global	__aeabi_f2d
	.global	__aeabi_dmul
	.global	__aeabi_d2f
	.align	2
	.global	getSubMatrix
	.type	getSubMatrix, %function
getSubMatrix:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 416
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #420
	str	r2, [sp, #192]
	str	r1, [sp, #196]
	ldr	ip, [sp, #192]
	mov	fp, r0
	mov	r1, r1, asl #4
	mov	r0, r2, asl #4
	ldr	r4, [sp, #196]
	add	r3, fp, r0
	add	r2, fp, r1
	ldr	r5, [r2, ip, asl #2]
	ldr	r6, [r3, r4, asl #2]
	str	r0, [sp, #188]
	add	r0, r5, r6
	ldr	r8, [r3, ip, asl #2]
	ldr	r7, [r2, r4, asl #2]
	str	r1, [sp, #184]
	bl	__aeabi_i2f
	mov	r4, r0
	rsb	r0, r7, r8
	bl	__aeabi_i2f
	mov	r1, r0
	mov	r0, r4
	bl	__aeabi_fdiv
	bl	atanf
	mov	sl, r0
	rsb	r0, r5, r6
	bl	__aeabi_i2f
	mov	r4, r0
	add	r0, r8, r7
	bl	__aeabi_i2f
	mov	r1, r0
	mov	r0, r4
	bl	__aeabi_fdiv
	bl	atanf
	mov	r1, r0
	mov	r0, sl
	bl	__aeabi_fsub
	mov	r1, #1056964608
	bl	__aeabi_fmul
	mov	r8, r0
	mov	r1, r8
	mov	r0, sl
	bl	__aeabi_fsub
	add	r6, sp, #216
	add	r7, sp, #208
	bl	__aeabi_f2d
	mov	r2, r6
	mov	r3, r7
	bl	sincos
	mov	r3, #1073741824
	mov	r2, #0
	add	r3, r3, #8388608
	add	r1, sp, #208
	ldmia	r1, {r0-r1}
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	add	r5, sp, #216
	ldmia	r5, {r4-r5}
	bl	lroundf
	mov	r3, #1073741824
	mov	r2, #0
	add	r3, r3, #8388608
	str	r0, [sp, #180]
	mov	r1, r5
	mov	r0, r4
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	bl	lroundf
	str	r0, [sp, #176]
	mov	r0, r8
	bl	__aeabi_f2d
	mov	r2, r6
	mov	r3, r7
	bl	sincos
	mov	r3, #1073741824
	mov	r2, #0
	add	r3, r3, #8388608
	add	r1, sp, #208
	ldmia	r1, {r0-r1}
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	add	r5, sp, #216
	ldmia	r5, {r4-r5}
	bl	lroundf
	mov	r3, #1073741824
	mov	r2, #0
	add	r3, r3, #8388608
	str	r0, [sp, #172]
	mov	r1, r5
	mov	r0, r4
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	bl	lroundf
	ldr	r5, .L39
	mov	r4, r5
	str	r0, [sp, #168]
	ldmia	r4!, {r0, r1, r2, r3}
	add	ip, sp, #352
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r4!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r4!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r4, {r0, r1, r2, r3}
	add	r5, r5, #64
	stmia	ip, {r0, r1, r2, r3}
	add	lr, sp, #288
	ldmia	r5!, {r0, r1, r2, r3}
	mov	ip, lr
	str	lr, [sp, #4]
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r5!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r5!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	add	r0, sp, #192
	ldmia	r0, {r0, r1}	@ phole ldm
	ldr	r2, [sp, #188]
	mov	r6, r0, asl #2
	ldr	r3, [sp, #184]
	mov	r4, r1, asl #2
	add	r2, r6, r2
	add	lr, r4, r3
	str	r2, [sp, #164]
	add	r4, r4, r0
	add	r6, r6, r1
	ldmia	r5, {r0, r1, r2, r3}
	add	r5, sp, #416
	add	r7, r5, lr
	ldr	lr, [sp, #164]
	add	sl, r5, r6, asl #2
	add	r6, r5, lr
	ldr	lr, [sp, #168]
	add	r8, r5, r4, asl #2
	add	r4, fp, #32
	add	r5, fp, #48
	str	r4, [sp, #200]
	str	r5, [sp, #204]
	rsb	r5, lr, #0
	ldr	lr, [sp, #176]
	stmia	ip, {r0, r1, r2, r3}
	ldr	r0, [sp, #180]
	ldr	r1, [sp, #172]
	ldr	r2, [sp, #168]
	rsb	r4, lr, #0
	str	r1, [r7, #-64]
	str	r0, [r7, #-128]
	str	r5, [r8, #-64]
	str	r4, [r8, #-128]
	str	r2, [sl, #-64]
	str	lr, [sl, #-128]
	str	r1, [r6, #-64]
	str	r0, [r6, #-128]
	ldr	r3, [fp, #16]
	add	r1, sp, #200
	ldmia	r1, {r1, r2}	@ phole ldm
	add	r9, fp, #16
	ldr	r4, [fp, #0]
	ldr	r5, [fp, #32]
	ldr	ip, [fp, #48]
	ldr	lr, [r9, #4]
	ldr	r0, [fp, #4]
	ldr	r1, [r1, #4]
	ldr	r2, [r2, #4]
	str	r3, [sp, #40]
	ldr	r3, [r9, #8]
	str	r4, [sp, #116]
	str	r5, [sp, #44]
	str	ip, [sp, #48]
	str	lr, [sp, #112]
	str	r0, [sp, #80]
	str	r1, [sp, #24]
	str	r2, [sp, #28]
	str	r3, [sp, #104]
	add	r5, sp, #200
	ldmia	r5, {r5, ip}	@ phole ldm
	ldr	r1, [sp, #200]
	ldr	r4, [fp, #8]
	ldr	r5, [r5, #8]
	ldr	ip, [ip, #8]
	ldr	r0, [fp, #12]
	ldr	r1, [r1, #12]
	ldr	r2, [sp, #204]
	ldr	lr, [r9, #12]
	str	r4, [sp, #72]
	str	r5, [sp, #12]
	str	ip, [sp, #16]
	str	r0, [sp, #64]
	str	r1, [sp, #124]
	ldr	sl, [r2, #12]
	str	lr, [sp, #96]
	add	r8, sp, #224
	add	lr, sp, #352
.L34:
	ldr	r3, [lr, #0]
	ldr	r1, [sp, #64]
	ldr	r0, [sp, #116]
	mul	r1, r3, r1
	mul	r0, r3, r0
	ldr	ip, [sp, #80]
	ldr	r4, [sp, #72]
	mul	ip, r3, ip
	mul	r4, r3, r4
	ldr	r2, [lr, #4]
	ldr	r5, [sp, #96]
	ldr	r6, [sp, #40]
	mla	r5, r2, r5, r1
	mla	r6, r2, r6, r0
	ldr	r1, [sp, #112]
	ldr	r0, [sp, #104]
	mla	r1, r2, r1, ip
	mla	r0, r2, r0, r4
	ldr	r3, [lr, #8]
	ldr	ip, [sp, #124]
	ldr	r4, [sp, #44]
	mla	ip, r3, ip, r5
	mla	r4, r3, r4, r6
	ldr	r5, [sp, #24]
	ldr	r6, [sp, #12]
	mla	r5, r3, r5, r1
	mla	r6, r3, r6, r0
	ldr	r2, [lr, #12]
	ldr	r3, [sp, #48]
	ldr	r1, [sp, #28]
	ldr	r0, [sp, #16]
	mla	r3, r2, r3, r4
	mla	r7, sl, r2, ip
	mla	r1, r2, r1, r5
	mla	r0, r2, r0, r6
	add	lr, lr, #16
	add	r4, sp, #416
	cmp	lr, r4
	str	r3, [r8, #0]
	str	r1, [r8, #4]
	str	r0, [r8, #8]
	str	r7, [r8, #12]
	add	r8, r8, #16
	bne	.L34
	ldr	r3, [sp, #272]
	str	r3, [sp, #160]
	ldr	r3, [sp, #276]
	str	r3, [sp, #156]
	ldr	r3, [sp, #280]
	str	r3, [sp, #152]
	ldr	r3, [sp, #284]
	ldr	r2, [sp, #228]
	ldr	r1, [sp, #232]
	add	r0, sp, #236
	ldmia	r0, {r0, ip}	@ phole ldm
	add	r4, sp, #244
	ldmia	r4, {r4, r5}	@ phole ldm
	str	r3, [sp, #148]
	ldr	r3, [sp, #224]
	add	r8, sp, #260
	ldmia	r8, {r8, sl, lr}	@ phole ldm
	add	r6, sp, #252
	ldmia	r6, {r6, r7}	@ phole ldm
	str	r3, [fp, #0]
	str	r2, [fp, #4]
	str	r1, [fp, #8]
	str	r0, [fp, #12]
	str	ip, [fp, #16]
	stmib	r9, {r4, r5}	@ phole stm
	ldr	r4, [sp, #200]
	ldr	r5, [sp, #160]
	str	r6, [r9, #12]
	str	r7, [fp, #32]
	stmib	r4, {r8, sl, lr}	@ phole stm
	str	r5, [fp, #48]
	ldr	ip, [sp, #204]
	add	r0, sp, #152
	ldmia	r0, {r0, lr}	@ phole ldm
	ldr	r1, [sp, #148]
	str	lr, [ip, #4]
	str	r0, [ip, #8]
	str	r1, [ip, #12]
	ldr	r2, [sp, #292]
	ldr	r3, [sp, #288]
	add	r4, sp, #296
	ldmia	r4, {r4, r5}	@ phole ldm
	ldr	ip, [sp, #308]
	ldr	lr, [sp, #304]
	ldr	r0, [sp, #312]
	str	r2, [sp, #32]
	str	r3, [sp, #36]
	str	r4, [sp, #20]
	str	r5, [sp, #128]
	str	ip, [sp, #108]
	str	lr, [sp, #120]
	ldr	r1, [sp, #316]
	ldr	r2, [sp, #324]
	ldr	r3, [sp, #320]
	add	r4, sp, #328
	ldmia	r4, {r4, r5}	@ phole ldm
	ldr	ip, [sp, #340]
	ldr	lr, [sp, #336]
	str	r0, [sp, #100]
	str	r1, [sp, #92]
	str	r2, [sp, #84]
	str	r3, [sp, #88]
	str	r4, [sp, #76]
	str	r5, [sp, #68]
	str	ip, [sp, #56]
	str	lr, [sp, #60]
	add	r0, sp, #344
	ldmia	r0, {r0, sl}	@ phole ldm
	str	r0, [sp, #52]
	add	lr, sp, #224
	mov	r8, fp
.L35:
	ldr	r3, [r8, #0]
	ldr	r1, [sp, #60]
	ldr	r0, [sp, #36]
	mul	r1, r3, r1
	ldr	ip, [sp, #120]
	mul	r0, r3, r0
	ldr	r4, [sp, #88]
	mul	ip, r3, ip
	mul	r4, r3, r4
	ldr	r2, [r8, #4]
	ldr	r5, [sp, #56]
	ldr	r6, [sp, #32]
	mla	r5, r2, r5, r1
	ldr	r1, [sp, #108]
	mla	r6, r2, r6, r0
	ldr	r0, [sp, #84]
	mla	r1, r2, r1, ip
	mla	r0, r2, r0, r4
	ldr	r3, [r8, #8]
	ldr	ip, [sp, #52]
	ldr	r4, [sp, #20]
	mla	ip, r3, ip, r5
	ldr	r5, [sp, #100]
	mla	r4, r3, r4, r6
	ldr	r6, [sp, #76]
	mla	r5, r3, r5, r1
	mla	r6, r3, r6, r0
	ldr	r2, [r8, #12]
	ldr	r1, [sp, #92]
	ldr	r3, [sp, #128]
	ldr	r0, [sp, #68]
	mla	r1, r2, r1, r5
	mla	r7, sl, r2, ip
	mla	r3, r2, r3, r4
	mla	r0, r2, r0, r6
	str	r1, [lr, #4]
	ldr	r1, [sp, #4]
	str	r3, [lr, #0]
	str	r0, [lr, #8]
	str	r7, [lr, #12]
	add	lr, lr, #16
	cmp	lr, r1
	add	r8, r8, #16
	bne	.L35
	ldr	r3, [sp, #272]
	str	r3, [sp, #144]
	ldr	r3, [sp, #276]
	str	r3, [sp, #140]
	ldr	r3, [sp, #280]
	str	r3, [sp, #136]
	ldr	r3, [sp, #284]
	ldr	r2, [sp, #228]
	ldr	r1, [sp, #232]
	add	r0, sp, #236
	ldmia	r0, {r0, ip}	@ phole ldm
	add	r4, sp, #244
	ldmia	r4, {r4, r5}	@ phole ldm
	str	r3, [sp, #132]
	ldr	r3, [sp, #224]
	ldr	r6, [sp, #252]
	add	r7, sp, #256
	ldmia	r7, {r7, r8, sl, lr}	@ phole ldm
	str	r3, [fp, #0]
	str	r2, [fp, #4]
	str	r1, [fp, #8]
	str	r0, [fp, #12]
	str	ip, [fp, #16]
	stmib	r9, {r4, r5}	@ phole stm
	ldr	r4, [sp, #200]
	ldr	r5, [sp, #144]
	str	r6, [r9, #12]
	str	r7, [fp, #32]
	stmib	r4, {r8, sl, lr}	@ phole stm
	str	r5, [fp, #48]
	ldr	ip, [sp, #204]
	ldr	r0, [sp, #136]
	ldr	r1, [sp, #132]
	ldr	lr, [sp, #140]
	str	r0, [ip, #8]
	str	lr, [ip, #4]
	str	r1, [ip, #12]
	ldr	r3, [fp, #0]
	sub	r2, r3, #-67108863
	cmp	r3, #0
	sub	r2, r2, #66846720
	movlt	r3, r2
	mov	r3, r3, asr #18
	ldr	r2, [fp, #4]
	str	r3, [fp, #0]
	ldr	r3, [fp, #8]
	ldr	r1, [fp, #12]
	sub	ip, r2, #-67108863
	ldr	r0, [fp, #16]
	sub	r4, r3, #-67108863
	cmp	r2, #0
	sub	ip, ip, #66846720
	sub	r5, r1, #-67108863
	movlt	r2, ip
	sub	r4, r4, #66846720
	cmp	r3, #0
	sub	r6, r0, #-67108863
	movlt	r3, r4
	sub	r5, r5, #66846720
	cmp	r1, #0
	movlt	r1, r5
	sub	r6, r6, #66846720
	cmp	r0, #0
	movlt	r0, r6
	mov	r2, r2, asr #18
	mov	r3, r3, asr #18
	mov	r1, r1, asr #18
	mov	r0, r0, asr #18
	str	r0, [fp, #16]
	stmib	fp, {r2, r3}	@ phole stm
	str	r1, [fp, #12]
	ldr	r2, [r9, #4]
	add	r1, r9, #8
	ldmia	r1, {r1, r3}	@ phole ldm
	sub	r0, r2, #-67108863
	sub	ip, r1, #-67108863
	cmp	r2, #0
	sub	r0, r0, #66846720
	sub	r4, r3, #-67108863
	movlt	r2, r0
	sub	ip, ip, #66846720
	cmp	r1, #0
	movlt	r1, ip
	sub	r4, r4, #66846720
	cmp	r3, #0
	movlt	r3, r4
	mov	r2, r2, asr #18
	mov	r1, r1, asr #18
	mov	r3, r3, asr #18
	str	r2, [r9, #4]
	str	r3, [r9, #12]
	str	r1, [r9, #8]
	ldr	r3, [fp, #32]
	sub	r2, r3, #-67108863
	cmp	r3, #0
	sub	r2, r2, #66846720
	movlt	r3, r2
	mov	r3, r3, asr #18
	str	r3, [fp, #32]
	ldr	r3, [sp, #200]
	ldr	r2, [r3, #4]
	ldr	r1, [r3, #8]
	sub	r0, r2, #-67108863
	ldr	r3, [r3, #12]
	sub	ip, r1, #-67108863
	cmp	r2, #0
	sub	r0, r0, #66846720
	sub	r4, r3, #-67108863
	movlt	r2, r0
	sub	ip, ip, #66846720
	cmp	r1, #0
	movlt	r1, ip
	sub	r4, r4, #66846720
	cmp	r3, #0
	movlt	r3, r4
	ldr	r4, [sp, #200]
	mov	r2, r2, asr #18
	mov	r1, r1, asr #18
	mov	r3, r3, asr #18
	str	r2, [r4, #4]
	str	r1, [r4, #8]
	str	r3, [r4, #12]
	ldr	r3, [fp, #48]
	sub	r2, r3, #-67108863
	cmp	r3, #0
	sub	r2, r2, #66846720
	movlt	r3, r2
	mov	r3, r3, asr #18
	str	r3, [fp, #48]
	ldr	r5, [sp, #204]
	ldr	r2, [r5, #4]
	add	r1, r5, #8
	ldmia	r1, {r1, r3}	@ phole ldm
	sub	r0, r2, #-67108863
	sub	ip, r1, #-67108863
	cmp	r2, #0
	sub	r0, r0, #66846720
	sub	r4, r3, #-67108863
	movlt	r2, r0
	sub	ip, ip, #66846720
	cmp	r1, #0
	movlt	r1, ip
	sub	r4, r4, #66846720
	cmp	r3, #0
	movlt	r3, r4
	mov	r2, r2, asr #18
	mov	r1, r1, asr #18
	mov	r3, r3, asr #18
	str	r3, [r5, #12]
	str	r2, [r5, #4]
	str	r1, [r5, #8]
	add	sp, sp, #420
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L40:
	.align	2
.L39:
	.word	.LANCHOR0
	.size	getSubMatrix, .-getSubMatrix
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	ldr	ip, .L59
	sub	sp, sp, #64
	ldmia	ip!, {r0, r1, r2, r3}
	mov	lr, sp
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	lr, {r0, r1, r2, r3}
	add	r8, sp, #12
	mov	r7, sp
	mov	r5, r8
	mov	r4, #0
.L42:
	cmp	r4, #0
	beq	.L45
	ldr	r0, [r5, #-12]
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r3, #0
	bl	__aeabi_dcmpeq
	cmp	r0, #0
	beq	.L43
	cmp	r4, #1
	beq	.L46
.L45:
	ldr	r0, [r5, #-8]
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r3, #0
	bl	__aeabi_dcmpeq
	cmp	r0, #0
	beq	.L43
	cmp	r4, #2
	beq	.L47
.L46:
	ldr	r0, [r5, #-4]
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r3, #0
	bl	__aeabi_dcmpeq
	cmp	r0, #0
	beq	.L43
	cmp	r4, #3
	beq	.L44
.L47:
	ldr	r0, [r5, #0]
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r3, #0
	bl	__aeabi_dcmpeq
	cmp	r0, #0
	add	r4, r4, #1
	add	r5, r5, #16
	beq	.L43
	cmp	r4, #4
	bne	.L42
.L44:
	mov	r4, sp
.L53:
	ldr	r1, [r4, #0]
	ldr	r0, .L59+4
	bl	printf
	ldr	r1, [r4, #4]
	ldr	r0, .L59+4
	bl	printf
	ldr	r1, [r4, #8]
	ldr	r0, .L59+4
	bl	printf
	ldr	r1, [r4, #12]
	ldr	r0, .L59+4
	bl	printf
	mov	r0, #10
	bl	putchar
	add	r4, r4, #16
	add	r3, sp, #64
	cmp	r4, r3
	bne	.L53
	mov	r0, #0
	add	sp, sp, #64
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	bx	lr
.L43:
	mov	r6, #0
.L58:
	mov	r1, #0
	mov	r2, #1
	mov	r0, sp
	bl	getSubMatrix
	mov	r0, sp
	mov	r1, #0
	mov	r2, #2
	bl	getSubMatrix
	mov	r0, sp
	mov	r1, #0
	mov	r2, #3
	bl	getSubMatrix
	mov	r0, sp
	mov	r1, #1
	mov	r2, #2
	bl	getSubMatrix
	mov	r0, sp
	mov	r1, #1
	mov	r2, #3
	bl	getSubMatrix
	add	r6, r6, #1
	mov	r0, sp
	mov	r1, #2
	mov	r2, #3
	bl	getSubMatrix
	ldr	r0, .L59+8
	mov	r1, r6
	bl	printf
	mov	r5, r8
	mov	r4, #0
.L48:
	cmp	r4, #0
	beq	.L50
	ldr	r0, [r5, #-12]
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r3, #0
	bl	__aeabi_dcmpeq
	cmp	r0, #0
	beq	.L58
	cmp	r4, #1
	beq	.L51
.L50:
	ldr	r0, [r5, #-8]
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r3, #0
	bl	__aeabi_dcmpeq
	cmp	r0, #0
	beq	.L58
	cmp	r4, #2
	beq	.L52
.L51:
	ldr	r0, [r5, #-4]
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r3, #0
	bl	__aeabi_dcmpeq
	cmp	r0, #0
	beq	.L58
	cmp	r4, #3
	beq	.L44
.L52:
	ldr	r0, [r5, #0]
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r3, #0
	bl	__aeabi_dcmpeq
	cmp	r0, #0
	add	r4, r4, #1
	add	r5, r5, #16
	beq	.L58
	cmp	r4, #4
	bne	.L48
	b	.L44
.L60:
	.align	2
.L59:
	.word	.LANCHOR0+128
	.word	.LC0
	.word	.LC1
	.size	main, .-main
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	C.39.2998, %object
	.size	C.39.2998, 64
C.39.2998:
	.word	511
	.word	0
	.word	0
	.word	0
	.word	0
	.word	511
	.word	0
	.word	0
	.word	0
	.word	0
	.word	511
	.word	0
	.word	0
	.word	0
	.word	0
	.word	511
	.type	C.40.2999, %object
	.size	C.40.2999, 64
C.40.2999:
	.word	511
	.word	0
	.word	0
	.word	0
	.word	0
	.word	511
	.word	0
	.word	0
	.word	0
	.word	0
	.word	511
	.word	0
	.word	0
	.word	0
	.word	0
	.word	511
	.type	C.41.3010, %object
	.size	C.41.3010, 64
C.41.3010:
	.word	31
	.word	77
	.word	-11
	.word	26
	.word	-42
	.word	14
	.word	79
	.word	-53
	.word	-68
	.word	-10
	.word	45
	.word	90
	.word	34
	.word	16
	.word	38
	.word	-19
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"%d \000"
.LC1:
	.ascii	"Iteration: %d\012\000"
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
