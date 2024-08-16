	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 1
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
	stmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	subs	r6, r0, #0
	movgt	fp, r6, asl #2
	movgt	sl, r1
	movgt	r5, #0
	movgt	r8, #0
	movgt	r9, #0
	bgt	.L3
	b	.L2
.L6:
	cmp	r5, r4
	beq	.L4
	ldr	r0, [r7, r4, asl #2]
	bl	__aeabi_i2d
	mov	r2, r8
	mov	r3, r9
	bl	__aeabi_dcmpeq
	cmp	r0, #0
	beq	.L5
.L4:
	add	r4, r4, #1
	cmp	r6, r4
	bgt	.L6
	add	r5, r5, #1
	add	sl, sl, fp
	cmp	r6, r5
	ble	.L2
.L3:
	mov	r7, sl
	mov	r4, #0
	b	.L6
.L5:
	mov	r0, #0
	b	.L7
.L2:
	mov	r0, #1
.L7:
	ldmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
	.size	checkOffDiagonalZeros, .-checkOffDiagonalZeros
	.align	2
	.global	matrixMultiply
	.type	matrixMultiply, %function
matrixMultiply:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 72
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	sub	sp, sp, #72
	str	r2, [sp, #4]
	mov	sl, r0
	mov	r5, #0
	str	r1, [sp, #0]
	add	fp, r1, #16
	b	.L11
.L12:
	ldr	r2, [ip, #16]
	ldr	r3, [ip, #0]
	mul	r3, r8, r3
	mla	r2, r7, r2, r3
	ldr	r3, [ip, #32]
	mla	r2, r3, r6, r2
	ldr	r3, [ip, #48]
	mla	r3, r4, r3, r2
	str	r3, [r1], #4
	add	ip, ip, #4
	cmp	ip, fp
	bne	.L12
	add	r5, r5, #1
	add	r0, r0, #16
	cmp	r5, #4
	bne	.L11
	ldr	r2, [sp, #4]
	cmp	r2, #0
	addeq	r2, sp, #8
	beq	.L16
	add	r2, sp, #8
.L14:
	ldr	r3, [r2, #0]
	str	r3, [sl, #0]
	ldr	r3, [r2, #4]
	str	r3, [sl, #4]
	ldr	r3, [r2, #8]
	str	r3, [sl, #8]
	ldr	r3, [r2, #12]
	str	r3, [sl, #12]
	add	r2, r2, #16
	add	sl, sl, #16
	add	r3, sp, #72
	cmp	r2, r3
	bne	.L14
	b	.L17
.L16:
	ldr	r3, [r2, #0]
	str	r3, [r9, #0]
	ldr	r3, [r2, #4]
	str	r3, [r9, #4]
	ldr	r3, [r2, #8]
	str	r3, [r9, #8]
	ldr	r3, [r2, #12]
	str	r3, [r9, #12]
	add	r2, r2, #16
	add	r9, r9, #16
	add	r3, sp, #72
	cmp	r2, r3
	bne	.L16
	b	.L17
.L11:
	ldr	r8, [r0, #0]
	ldr	r7, [r0, #4]
	ldr	r6, [r0, #8]
	ldr	r4, [r0, #12]
	ldr	r9, [sp, #0]
	mov	r3, r5, asl #4
	add	r2, sp, #8
	add	r1, r2, r3
	mov	ip, r9
	b	.L12
.L17:
	add	sp, sp, #72
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	bx	lr
	.size	matrixMultiply, .-matrixMultiply
	.align	2
	.global	multiplyWithTransposed
	.type	multiplyWithTransposed, %function
multiplyWithTransposed:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 72
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	sub	sp, sp, #72
	str	r2, [sp, #4]
	mov	r9, r0
	mov	r4, r0
	mov	r5, #0
	str	r1, [sp, #0]
	b	.L23
.L24:
	ldr	r2, [ip, #4]
	ldr	r3, [ip, #0]
	mul	r3, sl, r3
	mla	r2, r8, r2, r3
	ldr	r3, [ip, #8]
	mla	r2, r3, r7, r2
	ldr	r3, [ip, #12]
	mla	r3, r6, r3, r2
	str	r3, [r0], #4
	add	r1, r1, #1
	add	ip, ip, #16
	cmp	r1, #4
	bne	.L24
	add	r5, r5, #1
	add	r4, r4, #16
	cmp	r5, #4
	bne	.L23
	ldr	r2, [sp, #4]
	cmp	r2, #0
	addeq	r2, sp, #8
	beq	.L28
	add	r2, sp, #8
.L26:
	ldr	r3, [r2, #0]
	str	r3, [r9, #0]
	ldr	r3, [r2, #4]
	str	r3, [r9, #4]
	ldr	r3, [r2, #8]
	str	r3, [r9, #8]
	ldr	r3, [r2, #12]
	str	r3, [r9, #12]
	add	r2, r2, #16
	add	r9, r9, #16
	add	r3, sp, #72
	cmp	r2, r3
	bne	.L26
	b	.L29
.L28:
	ldr	r3, [r2, #0]
	str	r3, [fp, #0]
	ldr	r3, [r2, #4]
	str	r3, [fp, #4]
	ldr	r3, [r2, #8]
	str	r3, [fp, #8]
	ldr	r3, [r2, #12]
	str	r3, [fp, #12]
	add	r2, r2, #16
	add	fp, fp, #16
	add	r3, sp, #72
	cmp	r2, r3
	bne	.L28
	b	.L29
.L23:
	ldr	sl, [r4, #0]
	ldr	r8, [r4, #4]
	ldr	r7, [r4, #8]
	ldr	r6, [r4, #12]
	ldr	fp, [sp, #0]
	mov	r3, r5, asl #4
	add	r2, sp, #8
	add	r0, r2, r3
	mov	ip, fp
	mov	r1, #0
	b	.L24
.L29:
	add	sp, sp, #72
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	bx	lr
	.size	multiplyWithTransposed, .-multiplyWithTransposed
	.align	2
	.global	apply_to_fixed_in_place
	.type	apply_to_fixed_in_place, %function
apply_to_fixed_in_place:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	str	r4, [sp, #-4]!
	mov	r1, r0
	mov	r4, #262144
	sub	ip, r4, #1
	add	r0, r0, #64
.L35:
	ldr	r3, [r1, #0]
	add	r2, r3, ip
	cmp	r3, #0
	movlt	r3, r2
	mov	r3, r3, asr #18
	str	r3, [r1, #0]
	ldr	r3, [r1, #4]
	add	r2, r3, ip
	cmp	r3, #0
	movlt	r3, r2
	mov	r3, r3, asr #18
	str	r3, [r1, #4]
	ldr	r3, [r1, #8]
	add	r2, r3, ip
	cmp	r3, #0
	movlt	r3, r2
	mov	r3, r3, asr #18
	str	r3, [r1, #8]
	ldr	r3, [r1, #12]
	add	r2, r3, ip
	cmp	r3, #0
	movlt	r3, r2
	mov	r3, r3, asr #18
	str	r3, [r1, #12]
	add	r1, r1, #16
	cmp	r1, r0
	bne	.L35
	ldmfd	sp!, {r4}
	bx	lr
	.size	apply_to_fixed_in_place, .-apply_to_fixed_in_place
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
	@ args = 0, pretend = 0, frame = 160
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #164
	str	r0, [sp, #12]
	mov	sl, r1
	mov	r8, r2
	mov	r0, r2, asl #4
	str	r0, [sp, #8]
	ldr	r1, [sp, #12]
	add	r2, r1, r0
	ldr	r9, [r2, sl, asl #2]
	mov	r3, sl, asl #4
	str	r3, [sp, #4]
	add	r3, r1, r3
	ldr	r5, [r3, r8, asl #2]
	ldr	r7, [r2, r8, asl #2]
	ldr	r6, [r3, sl, asl #2]
	add	r0, r5, r9
	bl	__aeabi_i2f
	mov	r4, r0
	rsb	r0, r6, r7
	bl	__aeabi_i2f
	mov	r1, r0
	mov	r0, r4
	bl	__aeabi_fdiv
	bl	atanf
	mov	fp, r0
	rsb	r0, r5, r9
	bl	__aeabi_i2f
	mov	r4, r0
	add	r0, r7, r6
	bl	__aeabi_i2f
	mov	r1, r0
	mov	r0, r4
	bl	__aeabi_fdiv
	bl	atanf
	mov	r1, r0
	mov	r0, fp
	bl	__aeabi_fsub
	mov	r1, #1056964608
	bl	__aeabi_fmul
	mov	r9, r0
	mov	r0, fp
	mov	r1, r9
	bl	__aeabi_fsub
	bl	__aeabi_f2d
	add	r2, sp, #24
	add	r3, sp, #16
	bl	sincos
	add	r7, sp, #24
	ldmia	r7, {r6-r7}
	mov	r4, #0
	mov	r5, #1073741824
	add	r5, r5, #8388608
	add	r1, sp, #16
	ldmia	r1, {r0-r1}
	mov	r2, r4
	mov	r3, r5
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	bl	lroundf
	str	r0, [sp, #0]
	mov	r0, r6
	mov	r1, r7
	mov	r2, r4
	mov	r3, r5
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	bl	lroundf
	mov	fp, r0
	mov	r0, r9
	bl	__aeabi_f2d
	add	r2, sp, #24
	add	r3, sp, #16
	bl	sincos
	add	r7, sp, #24
	ldmia	r7, {r6-r7}
	add	r1, sp, #16
	ldmia	r1, {r0-r1}
	mov	r2, r4
	mov	r3, r5
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	bl	lroundf
	mov	r9, r0
	mov	r0, r6
	mov	r1, r7
	mov	r2, r4
	mov	r3, r5
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	bl	lroundf
	mov	r6, r0
	ldr	r5, .L40
	add	r4, sp, #96
	mov	ip, r5
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	r4!, {r0, r1, r2, r3}
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	r4!, {r0, r1, r2, r3}
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	r4!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	r4, {r0, r1, r2, r3}
	add	ip, sp, #32
	add	r5, r5, #64
	ldmia	r5!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r5!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r5!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r5, {r0, r1, r2, r3}
	stmia	ip, {r0, r1, r2, r3}
	mov	r3, sl, asl #2
	ldr	r0, [sp, #4]
	add	r2, r3, r0
	add	r1, sp, #160
	add	ip, r1, r2
	str	r9, [ip, #-64]
	add	r3, r3, r8
	add	r0, r1, r3, asl #2
	rsb	r3, r6, #0
	str	r3, [r0, #-64]
	mov	r8, r8, asl #2
	add	sl, r8, sl
	add	r1, r1, sl, asl #2
	str	r6, [r1, #-64]
	ldr	r2, [sp, #8]
	add	r8, r8, r2
	add	r3, sp, #160
	add	r2, r3, r8
	str	r9, [r2, #-64]
	ldr	r3, [sp, #0]
	str	r3, [ip, #-128]
	rsb	r3, fp, #0
	str	r3, [r0, #-128]
	str	fp, [r1, #-128]
	ldr	r0, [sp, #0]
	str	r0, [r2, #-128]
	add	r0, sp, #96
	ldr	r1, [sp, #12]
	mov	r2, #0
	bl	matrixMultiply
	ldr	r0, [sp, #12]
	add	r1, sp, #32
	mov	r2, #1
	bl	multiplyWithTransposed
	ldr	r0, [sp, #12]
	bl	apply_to_fixed_in_place
	add	sp, sp, #164
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L41:
	.align	2
.L40:
	.word	.LANCHOR0
	.size	getSubMatrix, .-getSubMatrix
	.align	2
	.global	printMatrixArray
	.type	printMatrixArray, %function
printMatrixArray:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	subs	r6, r0, #0
	movgt	r9, r6, asl #2
	movgt	sl, r1
	movgt	r8, #0
	ldrgt	r7, .L48
	movgt	fp, #10
	bgt	.L44
	b	.L46
.L45:
	mov	r0, r7
	ldr	r1, [r5, r4, asl #2]
	bl	printf
	add	r4, r4, #1
	cmp	r6, r4
	bgt	.L45
	mov	r0, fp
	bl	putchar
	add	r8, r8, #1
	add	sl, sl, r9
	cmp	r6, r8
	ble	.L46
.L44:
	mov	r5, sl
	mov	r4, #0
	b	.L45
.L46:
	ldmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L49:
	.align	2
.L48:
	.word	.LC0
	.size	printMatrixArray, .-printMatrixArray
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #68
	mov	lr, sp
	ldr	ip, .L55
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	lr, {r0, r1, r2, r3}
	mov	r0, #4
	mov	r1, sp
	bl	checkOffDiagonalZeros
	cmp	r0, #0
	bne	.L51
	mov	r5, #0
	mov	r4, sp
	mov	sl, r5
	mov	r8, #1
	mov	r7, #2
	mov	r6, #3
	ldr	fp, .L55+4
	mov	r9, #4
.L52:
	mov	r0, sp
	mov	r1, sl
	mov	r2, r8
	bl	getSubMatrix
	mov	r0, sp
	mov	r1, sl
	mov	r2, r7
	bl	getSubMatrix
	mov	r0, sp
	mov	r1, sl
	mov	r2, r6
	bl	getSubMatrix
	mov	r0, sp
	mov	r1, r8
	mov	r2, r7
	bl	getSubMatrix
	mov	r0, sp
	mov	r1, r8
	mov	r2, r6
	bl	getSubMatrix
	mov	r0, sp
	mov	r1, r7
	mov	r2, r6
	bl	getSubMatrix
	add	r5, r5, #1
	mov	r0, fp
	mov	r1, r5
	bl	printf
	mov	r0, r9
	mov	r1, sp
	bl	checkOffDiagonalZeros
	cmp	r0, #0
	beq	.L52
.L51:
	mov	r0, #4
	mov	r1, sp
	bl	printMatrixArray
	mov	r0, #0
	add	sp, sp, #68
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L56:
	.align	2
.L55:
	.word	.LANCHOR0+128
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
