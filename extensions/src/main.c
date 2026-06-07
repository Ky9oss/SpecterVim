#include "mylib.h"
#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>

struct file_name {
  char *buf;
  idx_t n_alloc;
  char *start;
};

// export LD_LIBRARY_PATH=./lib:$LD_LIBRARY_PATH
int main() {
  printf("%s\n", greet("so"));
  printf("Hello so! 5 + 3 = %d", add(5, 3));
  return 0;
}

static inline bool
dot_or_dotdot (char const *file_name)
{
  if (file_name[0] == '.')
    {
      char sep = file_name[(file_name[1] == '.') + 1];
      return (! sep || ISSLASH (sep));
    }
  else
    return false;
}

static inline struct dirent const *
readdir_ignoring_dot_and_dotdot (DIR *dirp)
{
  while (true)
    {
      struct dirent const *dp = readdir (dirp);
      if (dp == NULL || ! dot_or_dotdot (dp->d_name))
        return dp;
    }
}

void find_dir_entry(struct stat *dot_sb, struct file_name *file_name,
                    size_t parent_height) {
  DIR *dirp = opendir("..");
  if (dirp == NULL)
    error(EXIT_FAILURE, errno, _("cannot open directory %s"),
          quote(nth_parent(parent_height)));

  int fd = dirfd(dirp);
  if ((0 <= fd ? fchdir(fd) : chdir("..")) < 0)
    error(EXIT_FAILURE, errno, _("failed to chdir to %s"),
          quote(nth_parent(parent_height)));

  struct stat parent_sb;
  if ((0 <= fd ? fstat(fd, &parent_sb) : stat(".", &parent_sb)) < 0)
    error(EXIT_FAILURE, errno, _("failed to stat %s"),
          quote(nth_parent(parent_height)));

  /* If parent and child directory are on different devices, then we
     can't rely on d_ino for useful i-node numbers; use lstat instead.  */
  bool use_lstat = (parent_sb.st_dev != dot_sb->st_dev);
}
