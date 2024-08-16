	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 4
	.eabi_attribute 18, 4
	.file	"matrixDiagV1.c"
	.global	__aeabi_dcmpgt
	.text
	.align	2
	.global	checkOffDiagonalZeros
	.type	checkOffDiagonalZeros, %function
checkOffDiagonalZeros:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	mov	r9, r0
	mov	sl, r1
	mov	fp, r0, asl #3
	mov	r8, #0
	b	.L2
.L5:
	cmp	r8, r6
	add	r6, r6, #1
	beq	.L3
	ldmia	r7, {r0, r1}	@ phole ldm
	bic	r1, r1, #-2147483648
	mov	r4, r0
	mov	r5, r1
	bl	__aeabi_dcmpgt
	cmp	r0, #0
	bne	.L4
.L3:
	add	r7, r7, #8
.L8:
	cmp	r6, r9
	ldr	r2, .L10
	ldr	r3, .L10+4
	blt	.L5
	add	r8, r8, #1
	add	sl, sl, fp
.L2:
	cmp	r8, r9
	movge	r0, #1
	bge	.L7
.L6:
	mov	r7, sl
	mov	r6, #0
	b	.L8
.L4:
	mov	r0, #0
.L7:
	ldmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L11:
	.align	2
.L10:
	.word	-350469331
	.word	1058682594
	.size	checkOffDiagonalZeros, .-checkOffDiagonalZeros
	.align	2
	.global	transposeMatrix
	.type	transposeMatrix, %function
transposeMatrix:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8, sl}
	mov	r8, r0
	mov	r6, r0, asl #3
	mov	sl, r2
	mov	r7, r1
	mov	r0, #0
	b	.L13
.L14:
	ldmdb	r1, {r3-r4}
	stmia	r5, {r3-r4}
.L16:
	add	r2, r2, r6
	cmp	ip, r8
	rsb	r3, r6, r2
	add	ip, ip, #1
	add	r1, r1, #8
	add	r5, r3, r0, asl #3
	blt	.L14
	add	r0, r0, #1
	add	r7, r7, r6
.L13:
	cmp	r0, r8
	movlt	r1, r7
	movlt	r2, sl
	movlt	ip, #0
	blt	.L16
.L17:
	ldmfd	sp!, {r4, r5, r6, r7, r8, sl}
	bx	lr
	.size	transposeMatrix, .-transposeMatrix
	.align	2
	.global	copyMatrix
	.type	copyMatrix, %function
copyMatrix:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	mov	r5, r0
	mov	r0, #0
	mov	fp, r1
	mov	r9, r2
	mov	sl, r5, asl #3
	mov	r1, r0
	b	.L19
.L20:
	ldmia	r3, {r3-r4}
	stmia	r6, {r3-r4}
.L22:
	cmp	r2, r5
	add	r3, r7, ip
	add	r6, r8, ip
	add	r2, r2, #1
	add	ip, ip, #8
	blt	.L20
	add	r0, r0, #1
	add	r1, r1, sl
.L19:
	cmp	r0, r5
	movlt	r2, #0
	addlt	r8, r9, r1
	addlt	r7, fp, r1
	movlt	ip, r2
	blt	.L22
.L23:
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	bx	lr
	.size	copyMatrix, .-copyMatrix
	.global	__aeabi_dmul
	.global	__aeabi_dadd
	.align	2
	.global	multiplyMatrices
	.type	multiplyMatrices, %function
multiplyMatrices:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #36
	str	r3, [sp, #4]
	mov	r3, r0, asl #3
	str	r0, [sp, #16]
	str	r1, [sp, #12]
	str	r2, [sp, #8]
	str	r3, [sp, #20]
	ldr	ip, [sp, #4]
	mov	r0, #0
	b	.L25
.L26:
	mov	r3, #0
	mov	r4, #0
	stmdb	r1, {r3-r4}
.L29:
	ldr	r3, [sp, #16]
	cmp	r2, r3
	add	r1, r1, #8
	add	r2, r2, #1
	blt	.L26
	ldr	r3, [sp, #20]
	add	r0, r0, #1
	add	ip, ip, r3
.L25:
	ldr	r3, [sp, #16]
	cmp	r0, r3
	movge	fp, #0
	movge	r9, fp
	bge	.L28
.L27:
	mov	r1, ip
	mov	r2, #0
	b	.L29
.L30:
	ldr	ip, [sp, #28]
	add	r3, r7, r8, asl #3
	ldmia	ip!, {r0-r1}
	ldmia	r3, {r2-r3}
	str	ip, [sp, #28]
	bl	__aeabi_dmul
	mov	r3, r1
	mov	r2, r0
	mov	r1, r5
	mov	r0, r4
	bl	__aeabi_dadd
	ldr	r3, [sp, #16]
	add	r6, r6, #1
	ldr	ip, [sp, #20]
	cmp	r6, r3
	mov	r4, r0
	mov	r5, r1
	add	r7, r7, ip
	blt	.L30
	add	r8, r8, #1
	cmp	r8, r3
	stmia	sl!, {r4-r5}
	bge	.L31
.L33:
	ldr	r3, [sp, #24]
	ldmia	sl, {r4-r5}
	str	r3, [sp, #28]
	ldr	r7, [sp, #8]
	mov	r6, #0
	b	.L30
.L31:
	ldr	ip, [sp, #20]
	add	fp, fp, #1
	add	r9, r9, ip
.L28:
	ldr	r3, [sp, #16]
	cmp	fp, r3
	bge	.L34
	ldr	ip, [sp, #12]
	ldr	r3, [sp, #4]
	add	ip, ip, r9
	str	ip, [sp, #24]
	add	sl, r3, r9
	mov	r8, #0
	b	.L33
.L34:
	add	sp, sp, #36
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
	.size	multiplyMatrices, .-multiplyMatrices
	.global	__aeabi_dsub
	.global	__aeabi_ddiv
	.align	2
	.global	getSubMatrix
	.type	getSubMatrix, %function
getSubMatrix:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 968
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #972
	str	r0, [sp, #52]
	mov	r5, r3, asl #3
	str	r3, [sp, #40]
	add	r0, r0, r3, asl #5
	ldr	r3, [sp, #1008]
	ldr	r4, [sp, #52]
	mov	ip, r3, asl #3
	add	lr, r0, ip
	add	r0, r0, r5
	ldmia	r0, {r8-r9}
	add	r3, r4, r3, asl #5
	add	r4, r3, r5
	ldmia	lr, {sl-fp}
	add	r3, r3, ip
	ldmia	r4, {r6-r7}
	str	r8, [sp, #56]
	str	r9, [sp, #60]
	add	r5, sp, #56
	ldmia	r5, {r4-r5}
	ldmia	r3, {r8-r9}
	str	r2, [sp, #44]
	str	r1, [sp, #48]
	mov	r2, sl
	mov	r3, fp
	mov	r0, r6
	mov	r1, r7
	str	r4, [sp, #936]
	str	r5, [sp, #940]
	str	sl, [sp, #944]
	str	fp, [sp, #948]
	str	r6, [sp, #952]
	str	r7, [sp, #956]
	str	r8, [sp, #960]
	str	r9, [sp, #964]
	bl	__aeabi_dadd
	add	r3, sp, #56
	ldmia	r3, {r2-r3}
	mov	r4, r0
	mov	r5, r1
	mov	r0, r8
	mov	r1, r9
	bl	__aeabi_dsub
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	bl	atan
	mov	r2, sl
	str	r0, [sp, #64]
	str	r1, [sp, #68]
	mov	r3, fp
	mov	r0, r6
	mov	r1, r7
	bl	__aeabi_dsub
	add	r3, sp, #56
	ldmia	r3, {r2-r3}
	mov	r4, r0
	mov	r5, r1
	mov	r0, r8
	mov	r1, r9
	bl	__aeabi_dadd
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	bl	atan
	mov	r2, r0
	mov	r3, r1
	add	r1, sp, #64
	ldmia	r1, {r0-r1}
	bl	__aeabi_dsub
	mov	r2, #0
	ldr	r3, .L37
	bl	__aeabi_dmul
	add	r6, sp, #96
	add	r7, sp, #88
	mov	r5, r1
	mov	r2, r6
	mov	r3, r7
	mov	r4, r0
	bl	sincos
	ldr	r8, [sp, #100]
	mov	r3, r5
	ldr	r5, [sp, #96]
	add	r1, sp, #64
	ldmia	r1, {r0-r1}
	mov	r2, r4
	str	r5, [sp, #32]
	str	r8, [sp, #28]
	bl	__aeabi_dsub
	add	sl, sp, #88
	ldmia	sl, {r9-sl}
	mov	r2, r6
	mov	r3, r7
	str	r9, [sp, #80]
	str	sl, [sp, #84]
	bl	sincos
	add	sl, r8, #-2147483648
	ldr	r3, [sp, #32]
	mov	r4, sl
	mov	r5, r4
	mov	r4, r3
	str	r4, [sp, #880]
	str	r5, [sp, #884]
	add	r5, sp, #80
	ldmia	r5, {r4-r5}
	ldr	fp, [sp, #100]
	ldr	r2, [sp, #28]
	str	sl, [sp, #20]
	str	r4, [sp, #872]
	str	r5, [sp, #876]
	ldr	sl, [sp, #96]
	str	r4, [sp, #896]
	str	r5, [sp, #900]
	add	r5, sp, #88
	ldmia	r5, {r4-r5}
	add	r8, sp, #936
	str	r4, [sp, #72]
	str	r5, [sp, #76]
	mov	r6, r3
	add	r5, fp, #-2147483648
	mov	r7, r2
	add	r1, sp, #872
	mov	r2, r8
	add	r3, sp, #904
	mov	r4, sl
	mov	r0, #2
	str	r6, [sp, #888]
	str	r7, [sp, #892]
	ldr	r9, .L37+4
	bl	multiplyMatrices
	str	r5, [sp, #24]
	str	r4, [sp, #888]
	str	r5, [sp, #892]
	add	r5, sp, #72
	ldmia	r5, {r4-r5}
	mov	r3, r8
	mov	r6, sl
	mov	r8, #128
	mov	r7, fp
	add	r1, sp, #904
	add	r2, sp, #872
	mov	r0, #2
	str	r6, [sp, #880]
	str	r7, [sp, #884]
	str	r4, [sp, #872]
	str	r5, [sp, #876]
	str	r4, [sp, #896]
	str	r5, [sp, #900]
	bl	multiplyMatrices
	mov	r1, r9
	mov	r2, r8
	add	r0, sp, #744
	bl	memcpy
	add	r1, r9, r8
	mov	r2, r8
	add	r0, sp, #616
	bl	memcpy
	ldr	r5, [sp, #1008]
	add	r8, sp, #968
	mov	r3, #40
	mla	r5, r3, r5, r8
	ldr	lr, [sp, #40]
	mla	lr, r3, lr, r8
	ldr	ip, [sp, #1008]
	mov	r8, sl
	ldr	sl, [sp, #40]
	str	r5, [sp, #36]
	ldr	r4, [sp, #32]
	ldr	r5, [sp, #28]
	ldr	r7, [sp, #24]
	add	r0, sp, #968
	mov	r9, fp
	add	r3, sl, ip, asl #2
	stmia	sp, {r4-r5}
	mov	r6, r9
	mov	r5, r8
	add	ip, ip, sl, asl #2
	add	sl, r0, r3, asl #3
	mov	r3, r8
	add	r9, sp, #72
	ldmia	r9, {r8-r9}
	add	ip, r0, ip, asl #3
	ldr	r2, [sp, #20]
	mov	r1, r4
	mov	r4, r7
	str	r8, [lr, #-352]
	str	r9, [lr, #-348]
	str	r3, [ip, #-352]
	str	r4, [ip, #-348]
	str	r5, [sl, #-352]
	str	r6, [sl, #-348]
	ldr	r3, [sp, #36]
	add	r5, sp, #80
	ldmia	r5, {r4-r5}
	str	r1, [sp, #8]
	str	r2, [sp, #12]
	str	r4, [lr, #-224]
	str	r5, [lr, #-220]
	str	r8, [r3, #-352]
	str	r9, [r3, #-348]
	ldmia	sp, {r3-r4}
	add	r9, sp, #8
	ldmia	r9, {r8-r9}
	str	r8, [ip, #-224]
	str	r9, [ip, #-220]
	str	r3, [sl, #-224]
	str	r4, [sl, #-220]
	ldr	r8, [sp, #36]
	add	r5, sp, #80
	ldmia	r5, {r4-r5}
	add	fp, sp, #488
	add	r1, sp, #744
	mov	r2, fp
	add	r7, sp, #360
	str	r4, [r8, #-224]
	str	r5, [r8, #-220]
	mov	r0, #4
	bl	transposeMatrix
	add	r1, sp, #616
	mov	r2, r7
	mov	r0, #4
	add	r4, sp, #104
	bl	transposeMatrix
	ldr	r1, [sp, #44]
	add	r2, sp, #232
	mov	r0, #4
	bl	transposeMatrix
	mov	r3, r4
	mov	r2, fp
	ldr	r1, [sp, #48]
	mov	r0, #4
	bl	multiplyMatrices
	ldr	r2, [sp, #48]
	mov	r1, r4
	mov	r0, #4
	bl	copyMatrix
	add	r1, sp, #744
	ldr	r2, [sp, #52]
	mov	r3, r4
	mov	r0, #4
	bl	multiplyMatrices
	mov	r2, r7
	ldr	r3, [sp, #52]
	mov	r1, r4
	mov	r0, #4
	bl	multiplyMatrices
	add	r1, sp, #616
	ldr	r2, [sp, #44]
	mov	r0, #4
	mov	r3, r4
	bl	multiplyMatrices
	mov	r1, r4
	ldr	r2, [sp, #44]
	mov	r0, #4
	bl	copyMatrix
	add	sp, sp, #972
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L38:
	.align	2
.L37:
	.word	1071644672
	.word	.LANCHOR0
	.size	getSubMatrix, .-getSubMatrix
	.align	2
	.global	freeMatrix
	.type	freeMatrix, %function
freeMatrix:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	mov	r4, r0
	ldr	r0, [r0, #0]
	bl	free
	ldr	r0, [r4, #4]
	bl	free
	ldr	r0, [r4, #8]
	bl	free
	ldr	r0, [r4, #12]
	bl	free
	mov	r0, r4
	bl	free
	ldmfd	sp!, {r4, lr}
	bx	lr
	.size	freeMatrix, .-freeMatrix
	.align	2
	.global	createIdentityMatrix
	.type	createIdentityMatrix, %function
createIdentityMatrix:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	mov	r5, r0
	mov	r0, r0, asl #2
	bl	malloc
	mov	r7, r5, asl #3
	mov	r4, #0
	mov	r6, r0
	b	.L42
.L43:
	bl	malloc
	str	r0, [r6, r4, asl #2]
	add	r4, r4, #1
.L42:
	cmp	r4, r5
	mov	r0, r7
	blt	.L43
	mov	ip, #0
	mov	lr, ip
	b	.L44
.L47:
	ldr	r2, [r6, lr]
	cmp	ip, r1
	add	r0, r2, r1, asl #3
	ldreq	r4, .L50
	addeq	r2, r2, r7
	moveq	r3, #0
	stmeqia	r2, {r3-r4}
.L45:
	movne	r3, #0
	movne	r4, #0
	stmneia	r0, {r3-r4}
.L46:
	add	r1, r1, #1
	cmp	r1, r5
	blt	.L47
	add	ip, ip, #1
	add	lr, lr, #4
.L44:
	cmp	ip, r5
	movlt	r7, ip, asl #3
	movlt	r1, #0
	blt	.L47
.L48:
	mov	r0, r6
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	bx	lr
.L51:
	.align	2
.L50:
	.word	1072693248
	.size	createIdentityMatrix, .-createIdentityMatrix
	.align	2
	.global	printMatrixArray
	.type	printMatrixArray, %function
printMatrixArray:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	mov	r8, r0
	mov	r7, r1
	mov	sl, r0, asl #3
	mov	r6, #0
	b	.L53
.L54:
	ldmdb	r5, {r2-r3}
	bl	printf
.L56:
	cmp	r4, r8
	ldr	r0, .L58
	add	r4, r4, #1
	add	r5, r5, #8
	blt	.L54
	mov	r0, #10
	bl	putchar
	add	r6, r6, #1
	add	r7, r7, sl
.L53:
	cmp	r6, r8
	movlt	r5, r7
	movlt	r4, #0
	blt	.L56
.L57:
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	bx	lr
.L59:
	.align	2
.L58:
	.word	.LC0
	.size	printMatrixArray, .-printMatrixArray
	.global	__aeabi_i2d
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 392
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #404
	bl	clock
	ldr	r1, .L64
	str	r0, [sp, #12]
	mov	r2, #128
	add	r0, sp, #272
	bl	memcpy
	ldr	r1, .L64+4
	mov	r2, #128
	add	r0, sp, #144
	bl	memcpy
	ldr	r1, .L64+8
	mov	r2, #128
	add	r0, sp, #16
	bl	memcpy
	mov	r0, #4
	add	r1, sp, #272
	bl	checkOffDiagonalZeros
	mov	r8, #0
	mov	r4, r0
	b	.L61
.L62:
	str	sl, [sp, #0]
	bl	getSubMatrix
	mov	r3, r4
	mov	r0, r5
	mov	r1, r7
	mov	r2, r6
	str	r9, [sp, #0]
	bl	getSubMatrix
	mov	r3, r4
	mov	r0, r5
	mov	r1, r7
	mov	r2, r6
	str	fp, [sp, #0]
	bl	getSubMatrix
	mov	r0, r5
	mov	r1, r7
	mov	r2, r6
	mov	r3, sl
	str	r9, [sp, #0]
	bl	getSubMatrix
	mov	r3, sl
	mov	r0, r5
	mov	r1, r7
	mov	r2, r6
	str	fp, [sp, #0]
	bl	getSubMatrix
	mov	r2, r6
	mov	r3, r9
	mov	r0, r5
	mov	r1, r7
	str	fp, [sp, #0]
	bl	getSubMatrix
	mov	r1, r8
	ldr	r0, .L64+12
	bl	printf
	mov	r0, #4
	add	r1, sp, #272
	bl	checkOffDiagonalZeros
	mov	r4, r0
.L61:
	add	r7, sp, #144
	add	r6, sp, #16
	mov	sl, #1
	add	r5, sp, #272
	cmp	r4, #0
	mov	r3, r4
	mov	r1, r7
	mov	r2, r6
	mov	r9, #2
	mov	fp, #3
	add	r8, r8, sl
	mov	r0, r5
	beq	.L62
	mov	r1, r5
	mov	r0, #4
	bl	printMatrixArray
	bl	clock
	ldr	r3, [sp, #12]
	rsb	r0, r3, r0
	bl	__aeabi_i2d
	mov	r2, #0
	ldr	r3, .L64+16
	bl	__aeabi_ddiv
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L64+20
	bl	printf
	mov	r0, #0
	add	sp, sp, #404
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L65:
	.align	2
.L64:
	.word	.LANCHOR0+256
	.word	.LANCHOR0+384
	.word	.LANCHOR0+512
	.word	.LC1
	.word	1093567616
	.word	.LC2
	.size	main, .-main
	.section	.rodata
	.align	3
.LANCHOR0 = . + 0
	.type	C.64.3028, %object
	.size	C.64.3028, 128
C.64.3028:
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.type	C.65.3029, %object
	.size	C.65.3029, 128
C.65.3029:
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.type	C.86.3063, %object
	.size	C.86.3063, 128
C.86.3063:
	.word	0
	.word	1077870592
	.word	0
	.word	1079197696
	.word	0
	.word	-1071251456
	.word	0
	.word	1077542912
	.word	0
	.word	-1069219840
	.word	0
	.word	1076625408
	.word	0
	.word	1079230464
	.word	0
	.word	-1068859392
	.word	0
	.word	-1068433408
	.word	0
	.word	-1071382528
	.word	0
	.word	1078362112
	.word	0
	.word	1079410688
	.word	0
	.word	1078001664
	.word	0
	.word	1076887552
	.word	0
	.word	1078132736
	.word	0
	.word	-1070399488
	.type	C.87.3064, %object
	.size	C.87.3064, 128
C.87.3064:
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.type	C.88.3065, %object
	.size	C.88.3065, 128
C.88.3065:
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.section	.rodata.str1.1,"aMS",%progbits,1
.LC0:
	.ascii	"%f \000"
.LC1:
	.ascii	"Iteration: %d\012\000"
.LC2:
	.ascii	"Execution time: %f seconds\012\000"
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
