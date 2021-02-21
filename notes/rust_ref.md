#Interesting blog reads
<!-- for vm/emulation -->
https://drewdevault.com/2018/09/10/Getting-started-with-qemu.html
https://www.youtube.com/watch?v=Xynotc9BKe8
https://youtu.be/4wbMcL1Optc
https://www.naut.ca/blog/2020/08/26/ubuntu-vm-on-macos-with-libvirt-qemu/

# Jon Hoo suggestions
6.824 Distributed systems https://pdos.csail.mit.edu/6.824/labs/lab-mr.html

#Learn basics:
https://doc.rust-lang.org/book/ <!-- Absolute basics -->
https://doc.rust-lang.org/cargo/reference/manifest.html <!-- Cargo ref -->
https://stevedonovan.github.io/rust-gentle-intro/readme.html <!-- Third party basics -->
https://learning-rust.github.io/docs/index.html <!-- Github's strangely specialized basics -->

#By example:
https://doc.rust-lang.org/stable/rust-by-example/index.html <!-- Most examples -->
https://doc.rust-lang.org/reference/ <!-- Alternative examples for specifics -->

#Learn advanced
https://github.com/rust-lang/rust-wiki-backup/blob/master/Doc-detailed-release-notes.md
https://bluejekyll.github.io/blog/rust/2017/08/06/type-parameters.html <!-- Generics -->

#Useful tricks
if_chain!()
	Crate to help with long if/if let/else statments

if let Some(f) = (|| a.b?.c?.d?.field)() {
	println!("Yes {}", f)
}
