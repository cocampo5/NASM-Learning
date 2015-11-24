	.file	"booyermooooore.c"
	.text
	.globl	max
	.type	max, @function
max:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %eax
	cmpl	%eax, -8(%rbp)
	cmovge	-8(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	max, .-max
	.globl	badCharHeuristic
	.type	badCharHeuristic, @function
badCharHeuristic:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movq	%rdx, -40(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L4
.L5:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movl	$-1, (%rax)
	addl	$1, -4(%rbp)
.L4:
	cmpl	$255, -4(%rbp)
	jle	.L5
	movl	$0, -4(%rbp)
	jmp	.L6
.L7:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbq	%al, %rax
	leaq	0(,%rax,4), %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	movl	-4(%rbp), %eax
	movl	%eax, (%rdx)
	addl	$1, -4(%rbp)
.L6:
	movl	-4(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L7
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	badCharHeuristic, .-badCharHeuristic
	.section	.rodata
	.align 8
.LC0:
	.string	"\n pattern occurs at shift = %d"
	.text
	.globl	search
	.type	search, @function
search:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$1072, %rsp
	movq	%rdi, -1064(%rbp)
	movq	%rsi, -1072(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	-1072(%rbp), %rax
	movq	%rax, %rdi
	call	strlen
	movl	%eax, -1048(%rbp)
	movq	-1064(%rbp), %rax
	movq	%rax, %rdi
	call	strlen
	movl	%eax, -1044(%rbp)
	leaq	-1040(%rbp), %rdx
	movl	-1048(%rbp), %ecx
	movq	-1072(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	badCharHeuristic
	movl	$0, -1056(%rbp)
	jmp	.L9
.L16:
	movl	-1048(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -1052(%rbp)
	jmp	.L10
.L12:
	subl	$1, -1052(%rbp)
.L10:
	cmpl	$0, -1052(%rbp)
	js	.L11
	movl	-1052(%rbp), %eax
	movslq	%eax, %rdx
	movq	-1072(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %edx
	movl	-1056(%rbp), %ecx
	movl	-1052(%rbp), %eax
	addl	%ecx, %eax
	movslq	%eax, %rcx
	movq	-1064(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	cmpb	%al, %dl
	je	.L12
.L11:
	cmpl	$0, -1052(%rbp)
	jns	.L13
	movl	-1056(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	-1056(%rbp), %edx
	movl	-1048(%rbp), %eax
	addl	%edx, %eax
	cmpl	-1044(%rbp), %eax
	jge	.L14
	movl	-1056(%rbp), %edx
	movl	-1048(%rbp), %eax
	addl	%edx, %eax
	movslq	%eax, %rdx
	movq	-1064(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	cltq
	movl	-1040(%rbp,%rax,4), %eax
	movl	-1048(%rbp), %edx
	subl	%eax, %edx
	movl	%edx, %eax
	jmp	.L15
.L14:
	movl	$1, %eax
.L15:
	addl	%eax, -1056(%rbp)
	jmp	.L9
.L13:
	movl	-1056(%rbp), %edx
	movl	-1052(%rbp), %eax
	addl	%edx, %eax
	movslq	%eax, %rdx
	movq	-1064(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	cltq
	movl	-1040(%rbp,%rax,4), %eax
	movl	-1052(%rbp), %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, %esi
	movl	$1, %edi
	call	max
	addl	%eax, -1056(%rbp)
.L9:
	movl	-1044(%rbp), %eax
	subl	-1048(%rbp), %eax
	cmpl	-1056(%rbp), %eax
	jge	.L16
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L17
	call	__stack_chk_fail
.L17:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	search, .-search
	.globl	main
	.type	main, @function
main:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movabsq	$4918848066053816897, %rax
	movq	%rax, -32(%rbp)
	movb	$0, -24(%rbp)
	movl	$4407873, -48(%rbp)
	leaq	-48(%rbp), %rdx
	leaq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	search
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L20
	call	__stack_chk_fail
.L20:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.9.2-10ubuntu13) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
